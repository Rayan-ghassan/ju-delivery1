import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusPage extends StatefulWidget {
  final String orderId;

  const OrderStatusPage({super.key, required this.orderId});

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  String orderStatus = 'Waiting for Acceptance'; // Initial status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order ID: ${widget.orderId}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              'Status: $orderStatus',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            if (orderStatus == 'Waiting for Acceptance') ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    orderStatus = 'Order Accepted'; // Update status
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Accept Order'),
              ),
            ] else if (orderStatus == 'Order Accepted') ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    orderStatus = 'Order Done'; // Mark as done
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Mark as Done'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
