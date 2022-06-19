import 'package:flutter/material.dart';
import 'package:phonediary/models/fetch_contacts.dart';
import 'package:phonediary/models/single_contact.dart';
import 'package:provider/provider.dart';

class ViewContact extends StatefulWidget {
  SingleContact contact;

  ViewContact(this.contact, {Key? key}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  final _contactNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    _contactNameController.text = widget.contact.contactName;
    _contactNumberController.text = widget.contact.contactNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void _editContact(String oldContactName, String oldContactNumber,
      String contactName, String contactNumber) {
      final oldCt = SingleContact(oldContactName, oldContactNumber);
      final newCt = SingleContact(contactName, contactNumber);

      setState(() {
        Provider.of<FetchContacts>(context, listen: false).updateContact(oldCt, newCt);
        widget.contact = newCt;

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

      _editContact(
        widget.contact.contactName,
        widget.contact.contactNumber,
        enteredContactName,
        enteredContactNumber,
    
      );

      _contactNameController.text = '';
      _contactNumberController.text = '';
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<FetchContacts>(context, listen: false).deleteContact(widget.contact);
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }, 
            icon: Icon(Icons.delete))
        ],
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/user.png",),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 25),
              child: Text(widget.contact.contactName, style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text("Contact Number", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 25),
              child: Text(widget.contact.contactNumber, style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                
                  child: MaterialButton(
                    color: Colors.grey[350],
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
                                                  child: const Text('Update Contact'),
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
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 5 ),
                          Text("Edit Contact"),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}