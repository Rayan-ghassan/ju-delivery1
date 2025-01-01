import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDoneOrdersPage extends StatefulWidget {
  @override
  State<MyDoneOrdersPage> createState() => _MyDoneOrdersPageState();
}

class _MyDoneOrdersPageState extends State<MyDoneOrdersPage> {
  // Function to clear all "done" orders using batch
  Future<void> _clearAllOrders() async {
    try {
      // Create a batch
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Get all "done" orders
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: 'done')
          .get();

      // Loop through the documents and add delete operations to the batch
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference); // Add delete operation for each order
      }

      // Commit the batch
      await batch.commit();

      // Show a success message (You can use Snackbar or any UI element here)
      print('All done orders have been cleared.');
    } catch (e) {
      // Handle any errors that occur during the deletion process
      print('Error clearing orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        title: const Text("My Done Orders"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _clearAllOrders,
            child: const Text("Clear All Orders"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('status', isEqualTo: 'done') // Fetch done orders
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final orders = snapshot.data!.docs;

                if (orders.isEmpty) {
                  return const Center(child: Text('No completed orders.'));
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
                                    : const Icon(Icons.fastfood, size: 50, color: Colors.grey), // تغيير الأيقونة هنا
                                title: Text(item['name']),
                                subtitle: Text("Price: ${item['price']} jd x ${item['quantity']}"),
                              );
                            }).toList(),

                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


