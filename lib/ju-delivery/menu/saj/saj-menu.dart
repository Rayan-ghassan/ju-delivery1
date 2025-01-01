//
// import 'package:fip8/ju-delivery/menu/controller.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import '../../cart.dart';
// import 'saj-menu-controller.dart';
//
// class SajMenu extends StatefulWidget {
//   const SajMenu({super.key});
//
//   @override
//   State<SajMenu> createState() => _SajMenuState();
// }
//
// class _SajMenuState extends State<SajMenu> with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   SajController sajcontroller = SajController();
//   SandwichesController controller = SandwichesController();
//   final DatabaseReference drinksRef = FirebaseDatabase.instance.ref('drinks');
//
//   @override
//   void initState() {
//     tabController = TabController(length: 3, vsync: this);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Ju Delivery',
//           style: TextStyle(color: Colors.white, fontSize: 30),
//         ),
//         backgroundColor: Colors.green.shade400,
//         centerTitle: true,
//         bottom: TabBar(
//           controller: tabController,
//           labelColor: Colors.white,
//           tabs: const [
//             Tab(text: 'Sandwiches'),
//             Tab(text: 'Side'),
//             Tab(text: 'Drinks'),
//           ],
//         ),
//         actions: [
//           Consumer<CartProvider>(
//             builder: (_, cart, __) => Stack(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.shopping_cart),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const CartPage()),
//                     );
//                   },
//                 ),
//                 if (cart.totalItems > 0)
//                   Positioned(
//                     right: 8,
//                     top: 8,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: Text(
//                         cart.totalItems.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: TabBarView(
//         controller: tabController,
//         children: [
//           Sandwiches(),
//           Side(),
//           drink(),
//         ],
//       ),
//     );
//   }
//
//   Widget Sandwiches() {
//     SandwichesController controller = SandwichesController();
//     return FutureBuilder<List<RestaurantItem>>(
//        future: sajcontroller.getSandwichtItem(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [Text('Error happened'), Icon(Icons.error_sharp)],
//             ),
//           );
//         }
//         if (!snapshot.hasData) {
//           return const Center(
//             child: SpinKitRing(
//               color: Colors.black,
//             ),
//           );
//         }
//
//         List<RestaurantItem> items = snapshot.data ?? [];
//         if (items.isEmpty) {
//           return const Center(
//             child: Text(
//               "No items  available.",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return buildRestaurantCard(items[index], context);
//           },
//         );
//       },
//     );
//   }
//
//
//     Widget Side  () {
//     return FutureBuilder<List<RestaurantItem>>(
//       future: sajcontroller.getSweetstItem(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [Text('Error happened'), Icon(Icons.error_sharp)],
//             ),
//           );
//         }
//         if (!snapshot.hasData) {
//           return const Center(
//             child: SpinKitRing(
//               color: Colors.black,
//             ),
//           );
//         }
//
//         List<RestaurantItem> items = snapshot.data ?? [];
//         if (items.isEmpty) {
//           return const Center(
//             child: Text(
//               "No items  available.",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return buildRestaurantCard(items[index], context);
//           },
//         );
//       },
//     );
//   }
//   Widget drink  () {
//     return FutureBuilder<List<RestaurantItem>>(
//       future: sajcontroller.getDrinktItem(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [Text('Error happened'), Icon(Icons.error_sharp)],
//             ),
//           );
//         }
//         if (!snapshot.hasData) {
//           return const Center(
//             child: SpinKitRing(
//               color: Colors.black,
//             ),
//           );
//         }
//
//         List<RestaurantItem> items = snapshot.data ?? [];
//         if (items.isEmpty) {
//           return const Center(
//             child: Text(
//               "No items  available.",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return buildRestaurantCard(items[index], context);
//           },
//         );
//       },
//     );
//   }
//
//
//
//   Widget buildRestaurantCard(RestaurantItem item, BuildContext context) {
//     return Card(
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
//       child: ListTile(
//         leading: Image.network(
//           item.logoUrl,
//            width: 100,
//            height: 180,
//           fit: BoxFit.cover,
//         ),
//         title: Text(
//           item.name,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Price: ${item.price.toString()} JD "),
//
//
//           ],
//         ),
//
//         trailing: Consumer<CartProvider>(
//           builder: (context, cart, child) {
//             bool isAdded = cart.items.containsKey(item.name);
//             return GestureDetector(
//               onTap: () {
//                 if (!isAdded) {
//                   cart.addItem(item);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('${item.name} added to cart')),
//                   );
//                 }
//               },
//               child: Text(
//                 isAdded ? "ADDED" : "ADD",
//                 style: TextStyle(
//                   color: isAdded ? Colors.green : Colors.blue,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }






