import 'package:cached_network_image/cached_network_image.dart';
import 'package:fip8/ju-delivery/menu/resturent%20menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fip8/ju-delivery/user/my-order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class Resturant1 extends StatelessWidget {
  Resturant1({super.key});
  ControllerResturant controller = Get.put(ControllerResturant());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          'Ju Delivery',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: controller.getRestaurantsData(), // Use controller to fetch data
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Column(
                children: [Text('Error occurred'), Icon(Icons.error_sharp)],
              );
            }
            if (!snapshot.hasData) {
              return getListShimer();
            }

            List<Restaurant> restaurants = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return getRestaurantListData(restaurants[index]);
              },
              itemCount: restaurants.length,
            );
          },
        ),
      ),
    );
  }

  // Shimmer effect for loading
  Widget getListShimer() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return getShimer();
      },
      itemCount: 10,
    );
  }

  // Shimmer UI
  Widget getShimer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: Card(
        color: Colors.white70,
        child: Column(children: [
          const SizedBox(height: 20),
          Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 200,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.zero),
              )),
          const SizedBox(height: 20),
          Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 70,
                height: 30,
                decoration: const BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.zero),
              )),
          const SizedBox(height: 20),
          Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
              )),
          const SizedBox(height: 20)
        ]),
      ),
    );
  }

  // Actual list data
  Widget getRestaurantListData(Restaurant restaurant) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: Card(
        color: Colors.green.shade50,
        child: Column(
          children: [
             SizedBox(height: 10),
            CachedNetworkImage(
              imageUrl: restaurant.imageUrl.isNotEmpty?restaurant.imageUrl:'assets/ju.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              restaurant.name,
              style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 22,
              ),
            ), ElevatedButton(
              onPressed: () {
                Get.to(() => RestaurantMenu(id: restaurant.id,));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: const Size(140, 35),
              ),
              child: const Text(
                'Go to menu',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class Restaurant {
  final String name;
   final String imageUrl;
   final String id ;

  Restaurant({required this.name, required this.imageUrl, required this.id });

  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    return Restaurant(
      name: doc['name'] ?? 'No Name',
       imageUrl: doc['imageUrl'] ?? AssetImage('assets/R.jpeg'),
      id: doc.id
    );
  }
}

class ControllerResturant extends GetxController {
  Future<List<Restaurant>> getRestaurantsData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .get();

    List<Restaurant> restaurants = snapshot.docs
        .map((doc) => Restaurant.fromFirestore(doc))
        .toList();

    return restaurants;
  }
}
