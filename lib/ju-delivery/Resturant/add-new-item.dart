import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNewItem extends StatefulWidget {
   final String id ;
  const AddNewItem({super.key,
    required this.id
  });

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController dishnamecontroller = TextEditingController();
  TextEditingController dishpricecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  FocusNode dishnamefocusnode = FocusNode();
  FocusNode dishpricefocusnode = FocusNode();
  FocusNode imagefocusnode = FocusNode();

  File? imageFile; // Variable to store the selected image
  final ImagePicker _picker = ImagePicker();
   String? _itemImageUrl;
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = 'sandwich';

  final List<String> categories = ['sandwich', 'sweets', 'drink'];

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {

      File imageFile = File(pickedFile.path);
      String fileName = basename(imageFile.path);
      Reference storageRef =
          FirebaseStorage.instance.ref().child("profile_pictures/$fileName");

      await storageRef
          .putFile(imageFile);
      String imageUrl = await storageRef.getDownloadURL();
      setState(() {
        _itemImageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ju Delivery',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.green.shade400,
                      backgroundImage: _itemImageUrl != null
                          ? NetworkImage(_itemImageUrl!)
                          : const AssetImage('assets/default-profile.png')
                              as ImageProvider,
                      child: _itemImageUrl == null
                          ? const Icon(Icons.add_a_photo,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: dishnamecontroller,
                    focusNode: dishnamefocusnode,
                    decoration: InputDecoration(
                      hintText: 'Enter your Dish name',
                      hintStyle: TextStyle(color: Colors.green.shade400),
                      labelText: 'Dish name',
                      labelStyle:
                          TextStyle(color: Colors.green.shade900, fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade900,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: dishpricecontroller,
                    focusNode: dishpricefocusnode,
                    decoration: InputDecoration(
                      hintText: 'Enter your Dish price',
                      hintStyle: TextStyle(color: Colors.green.shade400),
                      labelText: 'Dish price',
                      labelStyle:
                          TextStyle(color: Colors.green.shade900, fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade900,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  DropdownButton<String>(
                    value: selectedCategory,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.green.shade900),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade900,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  // Add Dish Button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String restaurantUid = widget.id;
                        if (restaurantUid.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid restaurant ID")),
                          );
                          return;
                        }
                        FirebaseFirestore.instance
                            .collection('restaurants')
                             .doc(restaurantUid)
                            .collection('menu')
                            .doc(selectedCategory).collection('item')
                            .add({
                          'name': dishnamecontroller.text.trim(),
                          'price': dishpricecontroller.text.trim(),
                          'logourl': _itemImageUrl,
                          'add': true,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Item added successfully"))
                        ); }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade500,
                      fixedSize: const Size(300, 40),
                    ),
                    child: const Text(
                      'Add item',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
