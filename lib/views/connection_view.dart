import 'package:domisy_sample/models/user_model.dart';
import 'package:domisy_sample/utils/api_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/io_client.dart';

import 'offer_view.dart';

class ConnectionView extends StatefulWidget {
  ConnectionView({Key key}) : super(key: key);

  _ConnectionViewState createState() => _ConnectionViewState();
}

class _ConnectionViewState extends State<ConnectionView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Connexion"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: emailController,
                              autofocus: true,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email), labelText: "e-mail"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            ElevatedButton.icon(
                              label: Icon(Icons.send),
                              icon: Text("Valider"),
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ConnectionStep2View(
                                          email: emailController.text)));
                                }
                              },
                            ),
                          ],
                        )),
                  )),
            )
          ],
        )));
  }
}

class ConnectionStep2View extends StatefulWidget {
  final String email;

  ConnectionStep2View({Key key, @required this.email}) : super(key: key);

  _ConnectionStep2ViewState createState() => _ConnectionStep2ViewState();
}

class _ConnectionStep2ViewState extends State<ConnectionStep2View> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Connexion"),
        ),
        body: Center(
            child: Column(
          children: [
            if (this._isLoading) LinearProgressIndicator(),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'avatar_picture',
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Text(widget.email),
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                icon: Icon(Icons.vpn_key),
                                labelText: "mot de passe",
                              ),
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: true,
                            ),
                            ElevatedButton.icon(
                              label: Icon(Icons.send),
                              icon: Text("Valider"),
                              onPressed: () async {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                setState(() {
                                  this._isLoading = true;
                                });
                                if (_formKey.currentState.validate()) {
                                  DomisyDio.authenticate(
                                          widget.email, passwordController.text)
                                      .then((result) {
                                    Navigator.pushNamed(
                                        context, OfferListView.routeName);
                                  });
                                }
                              },
                            ),
                          ],
                        )),
                  )),
            )
          ],
        )));
  }
}

class ConnectionStep3View extends StatefulWidget {
  ConnectionStep3View({Key key}) : super(key: key);

  _ConnectionStep3ViewState createState() => _ConnectionStep3ViewState();
}

class _ConnectionStep3ViewState extends State<ConnectionStep3View> {
  Future<List<User>> futureUsers;
  final client = UserRestClient(Dio());

  @override
  void initState() {
    super.initState();

    futureUsers = client.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Hero(
          tag: 'avatar_picture',
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png'),
          ),
        )),
        body: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? UserList(users: snapshot.data)
                : Center(child: CircularProgressIndicator());

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ));
  }
}
