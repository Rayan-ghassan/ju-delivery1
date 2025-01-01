
import 'package:fip8/ju-delivery/user/userinformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'menu/saj/saj-menu-controller.dart';



class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          'My Cart ',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartItemWidget(cartItem: cartItem);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: JD ${cart.totalPrice.toString()}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => UserInformationPage()); // Navigate to the user information page
                  },
                  child: const Text("Order Now"),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: cartItem.item.logourl.isNotEmpty
            ? Image.network(
          cartItem.item.logourl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 50, color: Colors.grey);
          },
        )
            : const Icon(Icons.fastfood, size: 50, color: Colors.grey),

        title: Text(
          cartItem.item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text("Price:JD ${cartItem.item.price.toStringAsFixed(2)}"),
        trailing: Container(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  cart.decreaseQuantity(cartItem.item.name);
                },
              ),
              Text(
                "${cartItem.quantity}",
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cart.increaseQuantity(cartItem.item.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
