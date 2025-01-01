import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fip8/ju-delivery/menu/saj/saj-module.dart';
import 'package:get/get.dart';

class SandwichesController {
  RxBool isloded = false.obs;
  final CollectionReference sandwichCollection =
  FirebaseFirestore.instance.collection('sandwich');

  Future<List<RestaurantItem>>? getSandwichtItem() async {
    isloded.value = true;
    await Future.delayed(Duration(seconds: 2));
    try {
      QuerySnapshot snapshot = await sandwichCollection.get();
      return snapshot.docs.map((doc) {
        return RestaurantItem.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching sandwich items: $e');
      return [];
    }
  }
}
