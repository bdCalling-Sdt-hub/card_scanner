class ContactsModel {
  final String id;
  final String imageUrl;
  final String name;
  final String designation;
  final String companyName;
  final String email;
  final String mobilePhone;
  final String landPhone;
  final String fax;
  final String website;
  final String note;
  final String address;
  final List<String> capturedImageList;

  ContactsModel({
    this.id = "",
    this.imageUrl = "",
    this.name = "",
    this.designation = "",
    this.companyName = "",
    this.email = "",
    this.mobilePhone = "",
    this.landPhone = "",
    this.fax = "",
    this.website = "",
    this.note = "",
    this.address = "",
    this.capturedImageList = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'designation': designation,
      'companyName': companyName,
      'email': email,
      'mobilePhone': mobilePhone,
      'landPhone': landPhone,
      'fax': fax,
      'website': website,
      'note': note,
      'address': address,
      'capturedImageList': capturedImageList,
    };
  }

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['id'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      name: json['name'] ?? "",
      designation: json['designation'] ?? "",
      companyName: json['companyName'] ?? "",
      email: json['email'] ?? "",
      mobilePhone: json['mobilePhone'] ?? "",
      landPhone: json['landPhone'] ?? "",
      fax: json['fax'] ?? "",
      website: json['website'] ?? "",
      note: json['note'] ?? "",
      address: json['address'] ?? "",
      capturedImageList: (json['capturedImageList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final ContactsModel otherContact = other as ContactsModel;
    return id == otherContact.id;
  }

  @override
  int get hashCode => id.hashCode;
}



class ContactGroup {
  final String name ;
  final List<ContactsModel> contactsList ;

  ContactGroup({required this.name, required this.contactsList});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contactsList': contactsList.map((contact) => contact.toJson()).toList(),
    };
  }

  factory ContactGroup.fromJson(Map<String, dynamic> json) {
    return ContactGroup(
      name: json['name'],
      contactsList: (json['contactsList'] as List)
          .map((contactJson) => ContactsModel.fromJson(contactJson))
          .toList(),
    );
  }
}