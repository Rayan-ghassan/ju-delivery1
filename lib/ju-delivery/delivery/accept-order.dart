import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/delivery/my-done-order.dart';
import 'package:flutter/material.dart';

class AcceptedOrdersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accepted Orders")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'accepted') // Fetch only accepted orders
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final cartItems = order['cartItems'] as List;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${order['fullName']}"),
                      Text("Phone: ${order['phone']}"),
                      Text("College: ${order['college']}"),
                      Text("Order Date: ${order['orderDate'].toDate()}"),
                      const Divider(),
                      ...cartItems.map((item) {
                        return ListTile(
                          leading: item['image'] != null && item['image'].isNotEmpty
                              ? Image.network(item['image'])
                              : Icon(Icons.fastfood, size: 40.0, color: Colors.grey),
                          title: Text(item['name']),
                          subtitle: Text("Price: \$${item['price']} x ${item['quantity']}"),
                        );
                      }).toList(),
                      ElevatedButton(
                        onPressed: () async {
                          // Update order status to "done"
                          await FirebaseFirestore.instance
                              .collection('orders')
                              .doc(order.id) // Get the order by its document ID
                              .update({'status': 'done'});

                          // Navigate to the "My Done Orders" page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyDoneOrdersPage(),
                            ),
                          );
                        },
                        child: const Text('Done'),
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
}




