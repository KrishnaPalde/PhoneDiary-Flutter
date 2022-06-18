import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/authentication.dart';
import 'HomeScreen.dart';
class SignUpScreen extends StatelessWidget {
  static const routeName = 'signup-screen';

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    var authenticate = Provider.of<Authentication>(context);
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if(user != null)
      {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    });

    var nameController = TextEditingController();
    var contactController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final name = TextFormField(
      keyboardType: TextInputType.name,
      controller: nameController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final contactNumber = TextFormField(
      keyboardType: TextInputType.phone,
      controller: contactController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Contact Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          var response = await authenticate.signupUser(nameController.text.toString(), contactController.text.toString(), emailController.text.toString(), passwordController.text.toString());
          if(response == 1)
          {
            Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error while creating account")));
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Create Account', style: TextStyle(color: Colors.white)),
      ),
    );

    final loginLabel = FlatButton(
      child: const Text(
        "Already have an account? Login here",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpScreen.routeName);
      },
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            name,
            SizedBox(height: 8.0),
            contactNumber,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            registerButton,
            loginLabel,
          ],
        ),
      ),
    );
  }
}