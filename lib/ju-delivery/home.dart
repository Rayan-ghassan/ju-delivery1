import 'package:fip8/ju-delivery/Resturant/menu-managment.dart';
import 'package:fip8/ju-delivery/Resturant/resturent-register.dart';
import 'package:fip8/ju-delivery/Resturant/typs-of-resturant.dart';
import 'package:fip8/ju-delivery/delivery/delivery-login.dart';
import 'package:fip8/ju-delivery/delivery/delivery-register.dart';
import 'package:fip8/ju-delivery/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/Ju-Delivery.jpg'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Resturant1());
                },
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.green.shade400,
                    fixedSize: const Size(280, 50)),
                child: const Text('order food ',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => deliveryRegister());
        
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: Colors.green.shade400,
                      fixedSize: const Size(280, 50)),
                  child: const Text(
                    'Delivery food ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                     Get.to(() => ResturentsRegister());
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: Colors.green.shade400,
                      fixedSize: const Size(280, 50)),
                  child: const Text(
                    'Resturant Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
