class User {
  final String name;
  final String contact;
  final String email;

  User(this.name, this.contact, this.email){}

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'email': email,
    };
  }

  User.fromMap(Map<String, dynamic> addressMap)
      : name = addressMap["name"],
        contact = addressMap["contact"],
        email = addressMap["email"];
  
}