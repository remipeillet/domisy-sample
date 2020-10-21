import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {


  SignUpView({Key key}) : super(key:key);

  _SignUpViewState createState() => _SignUpViewState ();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .headline
        .copyWith(
    );
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Inscription"),
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
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.email),
                                      labelText: "e-mail"),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextFormField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.group),
                                      labelText: "nom"),
                                  keyboardType: TextInputType.text,),
                                TextFormField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      labelText: "prenom"),
                                  keyboardType: TextInputType.text,),
                                ElevatedButton.icon(
                                  label: Icon(Icons.send),
                                  icon: Text("Valider"),
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState.validate()) {

                                    }
                                  },
                                ),
                              ],
                            )
                        ),
                      )
                  ),
                )
              ],
            )
        )
    );
  }
}