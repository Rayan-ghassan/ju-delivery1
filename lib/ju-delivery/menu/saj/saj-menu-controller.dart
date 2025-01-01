import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SajController {
  RxBool isloded = false.obs;

}

class RestaurantItem1 {
  final String name;
  final double price;
  final String logourl;

  RestaurantItem1({required this.name, required this.price, required this.logourl});

  factory RestaurantItem1.fromMap(Map<String, dynamic> data) {
    return RestaurantItem1(
      name: data['name'] ?? '',
      price: data['price'] != null ? double.tryParse(data['price'].toString()) ?? 0.0 : 0.0,
      logourl: data['logourl'] ?? '',
    );
  }
}


class CartItem {
  final RestaurantItem1 item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});
}

class CartProvider with ChangeNotifier {

  Map<String, CartItem> _items = {}; // Key is item name

  Map<String, CartItem> get items => _items;

  // Add item to cart
  void addItem(RestaurantItem1 item) {
    if (_items.containsKey(item.name)) {
      _items[item.name]!.quantity += 1;
    } else {
      _items[item.name] = CartItem(item: item);
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String itemName) {
    _items.remove(itemName);
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(String itemName) {
    if (_items.containsKey(itemName)) {
      _items[itemName]!.quantity += 1;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(String itemName) {
    if (_items.containsKey(itemName)) {
      if (_items[itemName]!.quantity > 1) {
        _items[itemName]!.quantity -= 1;
      } else {
        _items.remove(itemName);
      }
      notifyListeners();
    }
  }

  // Calculate total price
  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.item.price * cartItem.quantity;
    });
    return total;
  }

  // Total items in cart
  int get totalItems {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  // Clear cart
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}


