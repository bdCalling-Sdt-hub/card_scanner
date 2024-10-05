// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// class StorageExample extends StatefulWidget {
//   @override
//   _StorageExampleState createState() => _StorageExampleState();
// }
//
// class _StorageExampleState extends State  with WidgetsBindingObserver {
//   late List<Contact> contacts;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _companyController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     contacts = [];
//     loadContacts();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _designationController.dispose();
//     _companyController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   Future<void> loadContacts() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/contacts.json');
//       if (file.existsSync()) {
//         final data = await file.readAsString();
//         final List<dynamic> jsonList = json.decode(data);
//         setState(() {
//           contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
//         });
//       }
//     } catch (e) {
//       print("Error loading contacts: $e");
//     }
//   }
//
//   Future<void> saveContacts() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/contacts.json');
//       await file.writeAsString(json.encode(contacts.map((c) => c.toJson()).toList()));
//     } catch (e) {
//       print("Error saving contacts: $e");
//     }
//   }
//
//   String generateId() {
//     return DateTime.now().millisecondsSinceEpoch.toString();
//   }
//
//   Future<void> addContact() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         final id = generateId();
//         contacts.add(Contact(
//           id: id,
//           imageUrl: pickedFile.path,
//           name: _nameController.text,
//           designation: _designationController.text,
//           companyName: _companyController.text,
//           email: _emailController.text,
//           phoneNumber: _phoneController.text,
//           address: _addressController.text,
//         ));
//         saveContacts();
//         _nameController.clear();
//         _designationController.clear();
//         _companyController.clear();
//         _emailController.clear();
//         _phoneController.clear();
//         _addressController.clear();
//       });
//     }
//   }
//
//   Future<void> deleteContact(String id) async {
//     setState(() {
//       contacts.removeWhere((contact) => contact.id == id);
//       saveContacts();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts'),
//       ),
//       body: ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: FileImage(File(contacts[index].imageUrl)),
//             ),
//             title: Text(contacts[index].name),
//             subtitle: Text(contacts[index].designation),
//             onTap: () {
//               // Handle contact tap
//             },
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 deleteContact(contacts[index].id);
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addContact,
//         tooltip: 'Add Contact',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       saveContacts();
//     }
//   }
// }
