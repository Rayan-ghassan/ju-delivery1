import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrderPage extends StatelessWidget {
  final String orderId; // Order ID to fetch specific order data
  UserOrderPage({required this.orderId});

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Order"),
        backgroundColor: Colors.green.shade400,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId) // Fetch order by ID
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = snapshot.data!;
          final orderStatus = order['status'] ?? 'waiting'; // Get order status
          final cartItems = order['cartItems'] as List;
          final orderTime = order['orderDate'] as Timestamp?;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Status: $orderStatus", style: TextStyle(fontSize: 18)),
                if (orderTime != null)
                  Text("Order Time: ${formatDate(orderTime)}", style: TextStyle(fontSize: 16)),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: item['image'] != null
                              ? Image.network(item['image'], width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported),
                          title: Text(item['name']),
                          subtitle: Text("Price: JD ${item['price']} x ${item['quantity']}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

