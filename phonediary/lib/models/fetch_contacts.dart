import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/single_contact.dart';

class FetchContacts extends ChangeNotifier {
  List<SingleContact> _contacts = [];

  List<SingleContact>  get contacts {
    fetchAllContacts();
    return [..._contacts];
  }

  void uploadAndAddContact(SingleContact con){
    // Upload to firebase database
    FirebaseDatabase.instance.ref("contacts").child(con.contactName).set(con.toMap());
    fetchAllContacts();
  }

  void updateContact(SingleContact oldCon, SingleContact newCon)
  {
    // Update Contact on firebase
    // FirebaseDatabase.instance.ref("contacts").child(oldCon.contactName).set(newCon.toMap());

    FirebaseDatabase.instance.ref("contacts").child(oldCon.contactName).remove();
    FirebaseDatabase.instance.ref("contacts").child(newCon.contactName).set(newCon.toMap());
    // Then call fetchAllContacts
    fetchAllContacts();
  }
  void deleteContact(SingleContact con){
    // Delete from firebase database
    FirebaseDatabase.instance.ref("contacts").child(con.contactName).remove();
    fetchAllContacts();
    notifyListeners();
  }

 Future<void> fetchAllContacts() async {
    List<SingleContact> _con = [];
    var snapshot = await FirebaseDatabase.instance.ref("contacts").get();
    var data = snapshot.children;
    print(data.elementAt(0).value);
    for (var i = 0; i < data.length; i++) {
      _con.add(SingleContact.fromMap(Map<String, dynamic>.from(data.elementAt(i).value as Map)));
    }

    _contacts = _con;
    notifyListeners();
    // var iter = snapshot.children.iterator;
    // // _contacts.add(iter.current.value as SingleContact);
    // print(iter.current.value);
    // while (iter.moveNext()) {
    //   // _contacts.add(iter.current.value as SingleContact);
    //   print(iter.current.value);
    // }
 }
}