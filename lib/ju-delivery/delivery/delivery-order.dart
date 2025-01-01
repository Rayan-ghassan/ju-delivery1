import 'package:fip8/ju-delivery/delivery/accept-order.dart';
import 'package:fip8/ju-delivery/delivery/my-done-order.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Required for authentication

class DeliveryOrdersPage extends StatefulWidget {


  const DeliveryOrdersPage({
    Key? key,

  }) : super(key: key);

  @override
  _DeliveryOrdersPageState createState() => _DeliveryOrdersPageState();
}

class _DeliveryOrdersPageState extends State<DeliveryOrdersPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userName;
  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  // Fetch username from the 'delivery_persons' collection
  Future<void> _fetchUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
       if (user != null) {
        // Query Firestore for the username
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("delivery_persons")
            .doc(user.uid) // Assuming the document ID is the user's UID
            .get();

        if (snapshot.exists) {
          setState(() {
            _userName = snapshot['username'] as String?;
          });
        } else {
          print("User document not found in delivery_persons collection");
        }
       }
    } catch (e) {
      print("Error fetching username: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        title: const Text("Available Orders"),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  _userName ?? "none", // Display fetched username
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title:  Text('My Accepted Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcceptedOrdersPage()),
              );
            },
          ),
          ListTile(
            title: const Text('My Done Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDoneOrdersPage()),
              );
            },
          ),
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'pending') // Fetch pending orders
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(child: Text('No available orders.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final cartItems = List.from(order['cartItems']);

              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${order['fullName']}"),
                      Text("Phone: ${order['phone']}"),
                      Text("College: ${order['college']}"),
                      Text(
                        "Order Date: ${order['orderDate'] != null ? order['orderDate'].toDate() : 'Unknown'}",
                      ),
                      const Divider(),
                      ...cartItems.map((item) {
                        return ListTile(
                          leading: item['image'] != null && item['image'].isNotEmpty
                              ? Image.network(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.fastfood, size: 50, color: Colors.grey),
                          title: Text(item['name']),
                          subtitle: Text("Price: ${item['price']} jd x ${item['quantity']}"),
                        );
                      }).toList(),

                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => _acceptOrder(order.id),
                            child: const Text("Accept"),
                          ),
                          ElevatedButton(
                            onPressed: () => _rejectOrder(order.id),
                            child: const Text("Reject"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to show the password update dialog
  void _showPasswordUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newPassword = _newPasswordController.text;
                if (newPassword.isNotEmpty) {
                  //_updatePassword(newPassword);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a new password')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _acceptOrder(String orderId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': 'accepted'});
  }

  void _rejectOrder(String orderId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': 'rejected'});
  }
}
