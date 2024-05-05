class ContactsModel {
  final String id;
  final String imageUrl;
  final String name;
  final String designation;
  final String companyName;
  final String email;
  final String phoneNumber;
  final String address;

  ContactsModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.designation,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'designation': designation,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      designation: json['designation'],
      companyName: json['companyName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}

class ContactGroup {
  final String name ;
  final List<ContactsModel> contactsList ;

  ContactGroup({required this.name, required this.contactsList});
}