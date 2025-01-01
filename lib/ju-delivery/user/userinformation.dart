import 'package:fip8/ju-delivery/Resturant/typs-of-resturant.dart';
import 'package:fip8/ju-delivery/menu/saj/saj-menu-controller.dart';
import 'package:fip8/ju-delivery/user/my-order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../cart.dart';

class UserInformationPage extends StatefulWidget {
  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  SajController controller = Get.put(SajController());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  String? selectedCollege; // To store the selected college name
  final List<String> colleges = [
    'Engineering',
    'Arts',
    'Science',
    'Business',
    'IT',
    'Medicine',
    'Nursing',
    'Literature',
    'Law',
    'Sharia',
    'Agriculture',
    'Qualification',
    'Chemistry',
    'Student',
  ]; // List of colleges

  // Function to submit user information and order
  Future<void> submitInformation(BuildContext context) async {
    try {
      String fullName = fullNameController.text.trim();
      String phone = phoneController.text.trim();
      String college = selectedCollege ?? '';

      // Check for empty fields
      if (fullName.isEmpty || phone.isEmpty || college.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')),
        );
        return;
      }

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      // final userId = FirebaseAuth.instance.currentUser?.uid; // Get current user ID
      //
      // if (userId == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('something wrong ')),
      //   );
      //   return;
      // }

      // Create the order data to store in Firestore
      final orderData = {
         // 'userId': userId,  // Store user ID for easy reference
        'fullName': fullName,
        'phone': phone,
        'college': college,
        'orderDate': FieldValue.serverTimestamp(),  // Auto generate timestamp
        'cartItems': cartProvider.items.values.map((item) {
          return {
            'name': item.item.name,
            'image': item.item.logourl,
            'quantity': item.quantity,
            'price': item.item.price,
          };
        }).toList(),
        'status': 'pending',  // Initial status for the order
      };

      // Add order to Firestore
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      cartProvider.clearCart();

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Full Name TextField
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ))),
              ),
              SizedBox(height: 20),
              // Phone Number TextField
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        style: BorderStyle.solid,
                      )),
                ),
              ),
              SizedBox(height: 20),
              // College Dropdown
              DropdownButtonFormField<String>(
                value: selectedCollege,
                decoration: const InputDecoration(
                  labelText: 'College Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                items: colleges.map((college) {
                  return DropdownMenuItem<String>(
                    value: college,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Text(college),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCollege = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  await submitInformation(context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
