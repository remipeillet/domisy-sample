import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => SignUpStep2View()));
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

class SignUpStep2View extends StatefulWidget {


  SignUpStep2View({Key key}) : super(key:key);

  _SignUpStep2ViewState createState() => _SignUpStep2ViewState ();
}

class _SignUpStep2ViewState extends State<SignUpStep2View> {

  List<String> dogImages = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchFive();
    _scrollController.addListener(() {
      debugPrint("${_scrollController.position.maxScrollExtent}");
      debugPrint("${_scrollController.position.pixels}");
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //If we are at the bottom of the page
        fetchFive();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

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
            title: Hero(
              tag: 'avatar_picture',
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png'),
              ),
            )
        ),
        body: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: dogImages.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height*0.2,
              child: Image.network(dogImages[index], fit: BoxFit.fitWidth),
            );

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        )
    );
  }

  fetch() async {
    final response = await http.get('https://dog.ceo/api/breeds/image/random');
    if(response.statusCode == 200) {
      setState(() {
        dogImages.add(json.decode(response.body)['message']);
      });
    } else{
      throw Exception('Failed to load images');
    }
  }

  fetchFive() {
    for (int i = 0; i < 5; i++ ){
      fetch();
    }
  }
}