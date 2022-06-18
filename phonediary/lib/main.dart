import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/authentication.dart';
import 'package:phonediary/models/fetch_contacts.dart';
import 'package:phonediary/screens/HomeScreen.dart';
import 'package:phonediary/screens/LoginScreen.dart';
import 'package:phonediary/screens/SignupScreen.dart';
import 'package:provider/provider.dart';

void main() {
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Platform.isIOS?
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FetchContacts())
      ],
       child: CupertinoApp(
        title: 'Phone Diary',
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName:(p0) => HomeScreen(),
          LoginScreen.routeName:(p0) => LoginScreen(),
          SignUpScreen.routeName:(p0) => SignUpScreen(),
        },
       ),
     )
     : 
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FetchContacts())
      ],
       child: MaterialApp(
        title: 'Phone Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName:(context) => HomeScreen(),
          LoginScreen.routeName:(context) => LoginScreen(),
          SignUpScreen.routeName:(context) => SignUpScreen(),
        },
         ),
     );
  }
}

