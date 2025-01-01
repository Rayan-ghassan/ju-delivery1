import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/delivery/delivery-order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File class
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DeliveryLogin extends StatefulWidget {
  DeliveryLogin({super.key});

  @override
  State<DeliveryLogin> createState() => _DeliveryLoginState();
}

class _DeliveryLoginState extends State<DeliveryLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  // Pick image and convert to File
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Convert XFile to File
      File imageFile = File(pickedFile.path);

      // Upload the file to Firebase Storage
      String fileName = basename(imageFile.path);
      Reference storageRef =
          FirebaseStorage.instance.ref().child("profile_pictures/$fileName");

      // Upload the File directly (not the Uint8List)
      await storageRef
          .putFile(imageFile); // Corrected: Uploading the File directly
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

                    const SizedBox(height: 60),

                    TextFormField(
                      controller: usernameController,
                      focusNode: usernameFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a user name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: Colors.green.shade900, fontSize: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade900,
                              style: BorderStyle.solid),
                        ),
                        errorText: _isUsernameValid
                            ? null
                            : 'Username must have at least 2 words',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isUsernameValid = validateUsername(text);
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    // Password Field with validation
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      validator: (value){
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        };
                      },
                      decoration: InputDecoration(

                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.green.shade900, fontSize: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade900,
                              style: BorderStyle.solid),
                        ),
                        errorText: _isPasswordValid
                            ? null
                            : 'Enter password',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isPasswordValid = validatePassword(text);
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          buildAuthDataToFirebase(username, password, context);
                         }
                       },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
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

  void buildAuthDataToFirebase(String username, String password, BuildContext context) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("delivery_persons")
        .where("username", isEqualTo: username)
        .get();
    // Check if a user with the given username exists
    if (snapshot.docs.isNotEmpty) {
      // Retrieve user data
      var userData = snapshot.docs.first.data() as Map<String, dynamic>;

      // Compare the password
      if (userData["password"] == password) {
        print("Login successful!");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DeliveryOrdersPage()),
        );
      } else {
        print("Incorrect password!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Incorrect password")),
        );
      }
    } else {
      print("User not found!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not found")),
      );
    }}
  }

  // Username validation
  bool validateUsername(String username) {
    return username.trim().split(" ").length >= 2;
  }

  // Password validation
  bool validatePassword(String password) {
    return password.length == 10 && int.tryParse(password) != null;
  }

