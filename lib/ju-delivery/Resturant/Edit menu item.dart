import 'package:fip8/ju-delivery/menu/drinks.dart';
import 'package:fip8/ju-delivery/menu/sandwiches.dart';
import 'package:fip8/ju-delivery/menu/side.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMenuItem extends StatefulWidget {
  final String id ; // Restaurant unique identifier
  const EditMenuItem({super.key, required this.id});

  @override
  State<EditMenuItem> createState() => _EditMenuItemState();
}

class _EditMenuItemState extends State<EditMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text('Remove from Menu Item',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => SandwichesMenu(
                      id: widget.id)); // Pass restaurant ID
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: const Text(
                  "Edit Sandwiches Menu",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => Drinksenu(
                      id: widget.id)); // Pass restaurant ID
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: const Text("Edit Drinks Menu",
                    style: TextStyle(color: Colors.white, fontSize: 15))),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => SideMenu(
                      id: widget.id)); // Pass restaurant ID
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: const Text("Edit Side Menu",
                    style: TextStyle(color: Colors.white, fontSize: 15))),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
