import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'saj/saj-menu-controller.dart';

class RestaurantMenu extends StatefulWidget {
  final String id;
  const RestaurantMenu({super.key, required this.id});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> with SingleTickerProviderStateMixin {
  TabController? tabController;
  SajController sajcontroller = SajController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ju Delivery',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          // This is used after initialization in initState
          labelColor: Colors.white,
          tabs: const [
            Tab(text: 'Sandwiches'),
            Tab(text: 'Side'),
            Tab(text: 'Drinks'),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, __) =>
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartPage()),
                        );
                      },
                    ),
                    if (cart.totalItems > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cart.totalItems.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Sandwiches(),
          Side(),
          Drink(),
        ],
      ),
    );
  }

  // Sandwiches Tab
  Widget Sandwiches() {
    return FutureBuilder<List<RestaurantItem1>>(
      future: getSandwichItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Error happened'), Icon(Icons.error_sharp)],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitRing(
              color: Colors.black,
            ),
          );
        }

        List<RestaurantItem1> items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(
            child: Text(
              "No items available.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return buildRestaurantCard(items[index], context);
          },
        );
      },
    );
  }

  // Side Tab
  Widget Side() {
    return FutureBuilder<List<RestaurantItem1>>(
      future: getSideItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Error happened'), Icon(Icons.error_sharp)],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitRing(
              color: Colors.black,
            ),
          );
        }

        List<RestaurantItem1> items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(
            child: Text(
              "No items available.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return buildRestaurantCard(items[index], context);
          },
        );
      },
    );
  }

  // Drink Tab
  Widget Drink() {
    return FutureBuilder<List<RestaurantItem1>>(
      future: getDrinkItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Error happened'), Icon(Icons.error_sharp)],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitRing(
              color: Colors.black,
            ),
          );
        }

        List<RestaurantItem1> items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(
            child: Text(
              "No items available.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return buildRestaurantCard(items[index], context);
          },
        );
      },
    );
  }

  // Fetch Sandwich Items from Firestore
  Future<List<RestaurantItem1>> getSandwichItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.id)
          .collection('menu')
          .doc('sandwich')
          .collection('item')
          .get();

      if (snapshot.docs.isEmpty) {
        print("No sandwich items found for restaurant ${widget.id}");
        return [];
      }

      return snapshot.docs.map((doc) {
        return RestaurantItem1.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching sandwich items: $e');
      return [];
    }
  }


  // Fetch Side Items from Firestore
  Future<List<RestaurantItem1>> getSideItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.id)
          .collection('menu')
          .doc('sweets')
          .collection('item')
          .get();

      if (snapshot.docs.isEmpty) {
        print("No side items found for restaurant ${widget.id}");
        return [];
      }

      return snapshot.docs.map((doc) {
        return RestaurantItem1.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching side items: $e');
      return [];
    }
  }


  // Fetch Drink Items from Firestore
  Future<List<RestaurantItem1>> getDrinkItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.id)
          .collection('menu')
          .doc('drink')
          .collection('item')
          .get();

      if (snapshot.docs.isEmpty) {
        print("No drink items found for restaurant ${widget.id}");
        return [];
      }

      return snapshot.docs.map((doc) {
        return RestaurantItem1.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching drink items: $e');
      return [];
    }
  }


  // Build the restaurant card widget
  Widget buildRestaurantCard(RestaurantItem1 item, BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: ListTile(
        leading: item.logourl.isNotEmpty
            ? Image.network(
          item.logourl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 50, color: Colors.grey);
          },
        )
            : const Icon(Icons.fastfood, size: 50, color: Colors.grey),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("Price: ${item.price.toString()} JD"),
        trailing: Consumer<CartProvider>(
          builder: (context, cart, child) {
            bool isAdded = cart.items.containsKey(item.name);
            return GestureDetector(
              onTap: () {
                if (!isAdded) {
                  cart.addItem(item); // Add the item to the cart
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} added to cart')),
                  );
                }
              },
              child: Text(
                isAdded ? "ADDED" : "ADD",
                style: TextStyle(
                  color: isAdded ? Colors.green : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}
