import 'package:fip8/ju-delivery/Resturant/Edit%20menu%20item.dart';
import 'package:fip8/ju-delivery/Resturant/add-new-item.dart';
import 'package:fip8/ju-delivery/Resturant/resturent-register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuManagment extends StatelessWidget {
  final String username;
    final String id;

  const MenuManagment({
    Key? key,
    required this.username,
     required this.id,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ju Delivery',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome $username',
              style: TextStyle(color: Colors.green.shade700, fontSize: 20,),
            ),
            SizedBox(height: 30,),
            Text(
              'Restaurant Menu Management',
              style: TextStyle(
                  color: Colors.green.shade500,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() =>  AddNewItem(id : id ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: const Text('Add new item ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900))),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() =>  EditMenuItem(id: id,));

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: const Text('Remove from menu item ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900))),
            SizedBox(height: 30,),
            TextButton(onPressed: (){
              Get.to(() => ResturentsRegister());
            }
                , child: Text("Logout",style: TextStyle(color: Colors.green.shade500),))
          ],
        ),
      ),
    );
  }
}

