import 'package:get/get.dart';

class ControllerResturant {
  RxBool isloded = false.obs;

  Future<List<ResturantItem>> getdata() async {
    isloded.value = true;
    await Future.delayed(Duration(seconds: 1));
    List<ResturantItem> item = [];

    item.add(ResturantItem(
      id: "20",
      image:
          "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
      title: "saj Business ",
      buttom: "Go to menu",
    ));
    item.add(ResturantItem(
      id: "21",
      image:
          "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
      title: "saj scientific ",
      buttom: "Go to menu",
    ));
    item.add(ResturantItem(
      id: "22",
      image:
          "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
      title: "Snack way student  ",
      buttom: "Go to menu",
    ));
    item.add(ResturantItem(
      id: "23",
      image:
          "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
      title: "saj alTabb ",
      buttom: "Go to menu",
    ));
    item.add(ResturantItem(
      id: "24",
        image:
            "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
        title: "snack way clock tower ",
        buttom: "Go to menu",));
    item.add(ResturantItem(
      id: "25",
      image:
      "https://images.deliveryhero.io/image/talabat/restaurants/saj_talabat_pp638109455415711622.jpg?width=180",
      title: "milk bar",
      buttom: "Go to menu",));

    return item;
  }
}

class ResturantItem {
  String image;
  String title;
  String buttom;
  String id ;
  ResturantItem(
      {required this.image,
      required this.title,
        required this.id,
      required this.buttom});
}
