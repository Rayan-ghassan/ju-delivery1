import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/Resturant/menu-managment.dart';
import 'package:fip8/ju-delivery/Resturant/resturant-login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class ResturentsRegister extends StatefulWidget {
  const ResturentsRegister({Key? key}) : super(key: key);

  @override
  State<ResturentsRegister> createState() => _ResturentsRegisterState();
}

class _ResturentsRegisterState extends State<ResturentsRegister> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> _registerRestaurant(User user) async {
    try {
      DocumentReference restaurantRef = await FirebaseFirestore.instance.collection('restaurants').add({
        'name': usernameController.text.trim(),
        'phonenumber': phonenumberController.text.trim(),
        'password': passwordController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl' : _profileImageUrl,
        "id": user.uid
      });
      print('Restaurant registered with ID: ${restaurantRef.id}');

       String UID = restaurantRef.id.toString();
      await restaurantRef.collection('menu').doc('drink').set({});
      await restaurantRef.collection('menu').doc('sandwich').set({});
      await restaurantRef.collection('menu').doc('sweets').set({});

      Get.to(() => MenuManagment(
        username: usernameController.text.trim(),
         id : UID.toString(),
      ));
    } catch (e) {
      print("Error registering restaurant: $e");
      Get.snackbar('Error', 'Could not register restaurant. Please try again.');
    }
  }

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
      String imageUrl = await storageRef.getDownloadURL(); // Get download URL
      setState(() {
        _profileImageUrl = imageUrl; // Store the image URL
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.green.shade400,
                        backgroundImage:  _profileImageUrl!= null
                            ? NetworkImage(_profileImageUrl!)
                            : const AssetImage('assets/ju.png')
                        as ImageProvider,
                        child: _profileImageUrl == null
                            ? const Icon(Icons.add_a_photo,
                            size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 50),

                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter a username'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.green.shade900,
                            fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter a password'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.green.shade900,
                            fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextFormField(
                      controller: phonenumberController,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                      value == null || value.isEmpty || value.length != 10
                          ? 'Please enter a valid phone number'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.green.shade900,
                            fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email address ',
                        labelStyle: TextStyle(color: Colors.green.shade900,
                            fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
    if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;
      if (user != null) {
        print('User authenticated with UID: ${user.uid}');
        await _registerRestaurant(user);
      }
    } catch (e) {
    print("Error creating user: $e");
    Get.snackbar('Error', 'Could not create user. Please try again.');
     }}
                        },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      child: const Text('Register',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () => Get.to(() => ResturantLogin()),
                      child: Text(
                        "Already have an account? Click here",
                        style: TextStyle(color: Colors.green.shade400,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

