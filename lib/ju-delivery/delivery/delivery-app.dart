import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/delivery/my-done-order.dart';
import 'package:flutter/material.dart';
import 'package:fip8/ju-delivery/delivery/accept-order.dart';
import 'package:fip8/ju-delivery/delivery/delivery-order.dart';

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Delivery App')),
        drawer: Drawer(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('delivery_persons').doc().get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var user = snapshot.data!;
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.green.shade400),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user['profileImage']),
                        ),
                        SizedBox(width: 16),
                        Text(user['username'], style: TextStyle(fontSize: 24, color: Colors.white)),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Accepted  Orders'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptedOrdersPage()));
                    },
                  ),
                  ListTile(
                    title: const Text('Done Orders'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyDoneOrdersPage()));
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryOrdersPage()),
                  );
                },
                child: const Text("View Available Orders"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcceptedOrdersPage()),
                  );
                },
                child: const Text("View Accepted Orders"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


