import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/delivery/delivery-login.dart';
import 'package:fip8/ju-delivery/delivery/delivery-order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File class
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class deliveryRegister extends StatefulWidget {
  const deliveryRegister({super.key});

  @override
  State<deliveryRegister> createState() => _deliveryRegisterState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController phonenumberController = TextEditingController();
TextEditingController emailController = TextEditingController();

FocusNode usernameFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();
FocusNode phonenumberFocusNode = FocusNode();
final _formKey = GlobalKey<FormState>();
bool _isUsernameValid = true;
bool _isPasswordValid = true;
bool _isphonenumberdValid = true;
String? _profileImageUrl;
final ImagePicker _picker = ImagePicker();

// Pick image and convert to File
Future<void> pickImage() async {
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    String fileName = basename(imageFile.path);
    Reference storageRef =
        FirebaseStorage.instance.ref().child("profile_pictures/$fileName");
    await storageRef
        .putFile(imageFile); // Corrected: Uploading the File directly
    String imageUrl = await storageRef.getDownloadURL();

    // setState(() {
    //   _profileImageUrl = imageUrl; // Store the image URL
    // });
  }
}

class _deliveryRegisterState extends State<deliveryRegister> {
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
                    // GestureDetector(
                    //   onTap: pickImage,
                    //   child: CircleAvatar(
                    //     radius: 100,
                    //     backgroundColor: Colors.green.shade400,
                    //     backgroundImage: _profileImageUrl != null
                    //         ? NetworkImage(_profileImageUrl!)
                    //         : AssetImage('assets/delivery.jpg')
                    //             as ImageProvider,
                    //     child: _profileImageUrl == null
                    //         ? Icon(Icons.add_a_photo,
                    //             size: 50, color: Colors.white)
                    //         : null,
                    //   ),
                    // ),
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
                            : 'Username must have at least 1 words',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isUsernameValid = validateUsername(text);
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      validator: (value) {
                        validator:
                        (value) {
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
                        errorText: _isPasswordValid ? null : 'Enter  password',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isPasswordValid = validatePassword(text);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phonenumberController,
                      focusNode: phonenumberFocusNode,
                      obscureText: true,
                      validator: (value) {
                        validator:
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        };
                      },
                      decoration: InputDecoration(
                        labelText: 'phone number',
                        labelStyle: TextStyle(
                            color: Colors.green.shade900, fontSize: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade900,
                              style: BorderStyle.solid),
                        ),
                        errorText: _isphonenumberdValid
                            ? null
                            : 'Enter correct  phone number',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isphonenumberdValid = validatePhonenumber(text);
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    // Login Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await submitInformation(context);
                           Get.to(() => DeliveryOrdersPage());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    // TextButton(
                    //     onPressed: () {
                    //       Get.to(() =>DeliveryLogin());
                    //       setState(() {
                    //
                    //       });
                    //     },
                    //     child: Text(
                    //       "click if Already have account",
                    //       style: TextStyle(
                    //           color: Colors.green.shade400, fontSize: 18),
                    //     ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buildSaveDataToFirebase(User user) async {
    await FirebaseFirestore.instance.collection("delivery_persons").add({
      "userName": usernameController.text,
      "password": passwordController.text,
      "phonenumber": phonenumberController.text,
      "UserId": user.uid
    });
    setState(() {});
  }

  // Username validation
  bool validateUsername(String username) {
    return username.trim().split(" ").length >= 1;
  }

  // Password validation
  bool validatePassword(String password) {
    return password.length == 10 && int.tryParse(password) != null;

  }

  bool validatePhonenumber(String phonenumber) {
    // return phonenumber.length == 10 && int.tryParse(phonenumber) != null;
    return RegExp(r'^07[7-9]\d{7}$').hasMatch(phonenumber);
  }
}

Future<void> submitInformation(BuildContext context) async {
  try {
    String fullName = usernameController.text.trim();
    String password = passwordController.text.trim();
    String phonenumber =phonenumberController.text.trim();

    // Check for empty fields
    if (fullName.isEmpty || password.isEmpty || phonenumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }
    ;
    final userId = FirebaseAuth.instance.currentUser?.uid;
     Get.to(() => DeliveryOrdersPage());// Get current user ID

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    // Create the order data to store in Firestore
    final  deliverinfo= {
      'userId': userId,  // Store user ID for easy reference
      'usernmae': fullName,
      'phonenumber': phonenumber,
    };

    // Add order to Firestore
    await FirebaseFirestore.instance.collection('delivery_persons').add(deliverinfo);


    // Display a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('login successfully!')),
    );

    // Navigate back to the previous screen
    Navigator.pop(context);
  } catch (e) {
    // Display an error message if anything goes wrong
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
