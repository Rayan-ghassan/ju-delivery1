import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/Resturant/menu-managment.dart';
import 'package:fip8/ju-delivery/delivery/delivery-register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


class ResturantLogin extends StatefulWidget {
  ResturantLogin({super.key});

  @override
  State<ResturantLogin> createState() => _ResturantLoginState();
}

class _ResturantLoginState extends State<ResturantLogin> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  FocusNode usernamefocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;


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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const SizedBox(height: 250),

                TextFormField(
                  controller: usernamecontroller,
                  focusNode: usernamefocusnode,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle:
                        TextStyle(color: Colors.green.shade900, fontSize: 20),
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

                // Password Field with validation
                TextFormField(
                  controller: passwordcontroller,
                  focusNode: passwordfocusnode,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Colors.green.shade900, fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green.shade900,
                          style: BorderStyle.solid),
                    ),
                    errorText: _isPasswordValid
                        ? null
                        : 'Password must be exactly 10 digits',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _isPasswordValid = validatePassword(text);
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {

                        await buildAuthDataToFirebase(usernamecontroller.text,passwordcontroller.text,context);
                      }
                    },
                    child: Text('login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

}

bool validateUsername(String username) {
  return username.trim().split(" ").length >= 1;
}

// Password validation
bool validatePassword(String password) {
  return password.length == 6 && int.tryParse(password) != null;
}


Future<void> buildAuthDataToFirebase(String username, String password, BuildContext context) async {
  try {
    print("Username entered: ${username.trim()}");
    print("Password entered: $password");

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("restaurants")
        .where("name", isEqualTo: username.trim())
        .get();

    if (snapshot.docs.isNotEmpty) {

      var userData = snapshot.docs.first.data() as Map<String, dynamic>;
      String restaurantId = snapshot.docs.first.id;


      if (userData["password"] == password) {
        print("Login successful!");

        Get.to(() => MenuManagment(
          username: username,
          id: restaurantId,
        ));
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
    }
  } catch (e) {
    print("Error during login: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred during login. Please try again.")),
    );
  }
}


