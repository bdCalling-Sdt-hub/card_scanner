
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  final String imageUrl;
  final String name;
  final String designation;
  final String companyName;
  final String email;
  final String phoneNumber;
  final String address;

  Contact({
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
      'imageUrl': imageUrl,
      'name': name,
      'designation': designation,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StorageExample(),
    );
  }
}

class StorageExample extends StatefulWidget {
  @override
  _StorageExampleState createState() => _StorageExampleState();
}

class _StorageExampleState extends State<StorageExample> {
  List<Contact> contacts = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      if (file.existsSync()) {
        final data = await file.readAsString();
        final List<dynamic> jsonList = json.decode(data);
        setState(() {
          contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print("Error loading contacts: $e");
    }
  }

  Future<void> saveContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      await file.writeAsString(json.encode(contacts.map((c) => c.toJson()).toList()));
    } catch (e) {
      print("Error saving contacts: $e");
    }
  }

  Future<void> addContact() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        contacts.add(Contact(
          // imageUrl: pickedFile.path,
          imageUrl: "https://img.freepik.com/free-photo/cute-furry-cat-outdoors_23-2150679266.jpg?t=st=1713499828~exp=1713503428~hmac=c18d11a653ebeac2545d48a1778f1f469d40de70d517e12a4a30ac49aa2a70b8&w=1380",
          name: 'John Doe',
          designation: 'Developer',
          companyName: 'XYZ Corp',
          email: 'john.doe@example.com',
          phoneNumber: '1234567890',
          address: '123 Main St, City',
        ));
        saveContacts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: contacts[index].imageUrl.startsWith('http') ? CircleAvatar(backgroundImage:NetworkImage(contacts[index].imageUrl))
                : CircleAvatar(
              backgroundImage: FileImage(File(contacts[index].imageUrl)), // Assuming imageUrl is a file path
            ),
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].designation),
            onTap: () {
              // Handle contact tap
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
