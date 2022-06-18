import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/fetch_contacts.dart';
import 'package:phonediary/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    Provider.of<FetchContacts>(context);
    void handleClick(value)
    {
      switch(value.toString().toLowerCase()){
        case 'logout':
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        ),
      body: Consumer<FetchContacts>(
        builder: ((context, value, child) {
          return ListView.builder(
            itemCount: value.contacts.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 5),
                child: Text(value.contacts[i].contactName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              
              onTap: () {},
            ),
          );
        }),
      ),
    );
  }
}