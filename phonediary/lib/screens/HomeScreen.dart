import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonediary/models/fetch_contacts.dart';
import 'package:phonediary/models/single_contact.dart';
import 'package:phonediary/screens/LoginScreen.dart';
import 'package:phonediary/screens/ViewContact.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<SingleContact> _contacts = [];
  final _contactNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {

    _contacts = Provider.of<FetchContacts>(context).contacts;
    print(_contacts);
    void _addNewContact(
      String contactName, String contactNumber) {
      final newCt = SingleContact(contactName, contactNumber);

      setState(() {
        Provider.of<FetchContacts>(context, listen: false).uploadAndAddContact(newCt);
      });
    }

    void _submitData() {
      if (_contactNumberController.text.isEmpty) {
        return;
      }
      final enteredContactName = _contactNameController.text;
      final enteredContactNumber = _contactNumberController.text;

      if (enteredContactName.isEmpty || enteredContactNumber.isEmpty) {
        return;
      }

      _addNewContact(
        enteredContactName,
        enteredContactNumber,
    
      );

      _contactNameController.text = '';
      _contactNumberController.text = '';
      Navigator.of(context).pop();
    }

 
 
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
      body: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 5),
                child: Text(_contacts[i].contactName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewContact(_contacts[i])));
              },
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, 
          builder: (_) {
            return GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                TextField(
                                  decoration: const InputDecoration(labelText: 'Contact Name'),
                                  controller: _contactNameController,
                                  
                                ),
                                TextField(
                                  decoration: const InputDecoration(labelText: 'Contact Number'),
                                  controller: _contactNumberController,
                                  keyboardType: TextInputType.number,
                                  
                                ),
                                
                                RaisedButton(
                                  child: const Text('Add Contact'),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: _submitData,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              behavior: HitTestBehavior.opaque
            );
          },
          );
        },
        child: Center(child: Icon(Icons.add)),
        ),
    );
  }
}