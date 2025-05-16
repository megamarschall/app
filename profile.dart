import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Имя';
  String phone = '+7 123 456 78 90';
  String description = 'Описание пользователя';
  String imagePath = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  imagePath.isEmpty
                      ? AssetImage('assets/default_avatar.png') as ImageProvider
                      : FileImage(File(imagePath)),
            ),
          ),
          TextField(
            controller: TextEditingController(text: name),
            decoration: InputDecoration(labelText: 'Имя'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextField(
            controller: TextEditingController(text: phone),
            decoration: InputDecoration(labelText: 'Телефон'),
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
          ),
          TextField(
            controller: TextEditingController(text: description),
            decoration: InputDecoration(labelText: 'Описание'),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
