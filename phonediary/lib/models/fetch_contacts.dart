import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/single_contact.dart';

class FetchContacts extends ChangeNotifier {
  List<SingleContact> _contacts = [
    SingleContact("Krishna", "9373996091"),
    SingleContact("Ashok", "9011698931")
  ];

  List<SingleContact>  get contacts {
    return [..._contacts];
  }

 Future<void> fetchAllContacts() async {
    notifyListeners();
 }
}