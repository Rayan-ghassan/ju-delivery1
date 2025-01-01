import 'package:fip8/ju-delivery/user/user-order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class MyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text("My Orders"),
        centerTitle: true,
      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid) // Use the real userId
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final orders = snapshot.data!.docs;

            if (orders.isEmpty) {
              return const Center(child: Text('You have no orders.'));
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final orderId = order.id;
                final orderStatus = order['status'];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ID: $orderId"),
                        Text("Status: $orderStatus"),
                        if (orderStatus == 'accepted')
                          ElevatedButton(
                            onPressed: () {
                              Future.delayed(Duration.zero, () {
                                Get.to(() => UserOrderPage(orderId: orderId));
                              });
                            },
                            child: const Text("View Details"),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )


    );
  }
}



