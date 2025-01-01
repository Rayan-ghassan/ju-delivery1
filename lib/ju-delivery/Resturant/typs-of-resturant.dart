import 'package:cached_network_image/cached_network_image.dart';
import 'package:fip8/ju-delivery/user/my-order.dart'; // My Orders Page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fip8/ju-delivery/Resturant/controller.dart';
import 'package:fip8/ju-delivery/menu/saj/saj-menu.dart'; // Saj Menu Page

class Resturant extends StatelessWidget {
  Resturant({super.key});
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
      drawer: Drawer(
        child: ListView(
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade400,
              ),
              child: const Text(
                'Ju Delivery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // My Orders Option
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('My Orders'),
              onTap: () {
                // Navigate to the MyOrdersPage
                Navigator.of(context).pop(); // Close the drawer
                Get.to(() => MyOrdersPage());
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Expanded(
          child: FutureBuilder(
            future: controller.getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Column(
                  children: [Text('Error occurred'), Icon(Icons.error_sharp)],
                );
              }
              if (!snapshot.hasData) {
                return getListShimer();
              }

              List<ResturantItem> item = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  return getListData(item[index]);
                },
                itemCount: item.length,
              );
            },
          ),
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
  Widget getListData(ResturantItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: Card(
        color: Colors.green.shade50,
        child: Column(
          children: [
            const SizedBox(height: 10),
            CachedNetworkImage(
              imageUrl: item.image,
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: const Size(140, 35),
              ),
              child: Text(
                item.buttom,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
