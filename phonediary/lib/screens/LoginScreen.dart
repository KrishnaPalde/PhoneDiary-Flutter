import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/authentication.dart';
import 'package:phonediary/screens/HomeScreen.dart';
import 'package:phonediary/screens/SignupScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login-screen';
  @override


  Widget build(BuildContext context) {
    Firebase.initializeApp();
    var authenticate = Provider.of<Authentication>(context);
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if(user != null)
      {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, ((route) => false));
      }
    });

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

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          if(emailController.text.toString().isNotEmpty && passwordController.text.toString().isNotEmpty)
          {
            var response = await authenticate.loginUser(emailController.text.toString(), passwordController.text.toString());
            if(response == 1)
            {
              Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error while login")));
            }
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final signupLabel = FlatButton(
      child: const Text(
        "Don't have an account? Create Account",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpScreen.routeName);
      },
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            // SizedBox(height: 25.0),
            signupLabel,
          ],
        ),
      ),
    );
  }
}