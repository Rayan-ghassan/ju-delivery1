import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  final String id ;
  const SideMenu({super.key, required this.id});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final CollectionReference sweetCollection;

  @override
  void initState() {
    super.initState();
    sweetCollection = FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.id)
        .collection('menu')
        .doc('sweets')
        .collection('item');
  }

  // Function to delete an item from the Firestore database
  void deleteItemFromDatabase(String itemId) async {
    try {
      await sweetCollection.doc(itemId).delete(); // Delete item by ID
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Side menu',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: sweetCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(child: Text('No Data Found'));
            }

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final itemId = doc.id;  // Get the document ID for the item
                final name = doc['name'] ?? 'No Name';
                final price = doc['price'] ?? 'No Price';
                final imageUrl = doc['logourl'] ?? '';

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        imageUrl.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        )
                            : const Icon(
                          Icons.fastfood,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: $price',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            // Show confirmation SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Are you sure you want to delete this item?'),
                                action: SnackBarAction(
                                  label: 'Yes',
                                  onPressed: () {
                                    deleteItemFromDatabase(itemId); // Delete the item if confirmed
                                  },
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.delete_rounded,
                            color: Colors.red.shade900,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Data Found'));
          }
        },
      ),
    );
  }
}


