class SingleContact {
  final String contactName;
  final String contactNumber;

  SingleContact(this.contactName,this.contactNumber){}

  Map<String, dynamic> toMap() {
    return {
      'contactName': contactName,
      'contactNumber': contactNumber,
    };
  }

  SingleContact.fromMap(Map<String, dynamic> addressMap)
      : contactName = addressMap["contactName"],
        contactNumber = addressMap["contactNumber"];
  
}