import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: const Color(0xFFFEEB50),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleOrders.length,
        itemBuilder: (context, index) {
          final order = sampleOrders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Chip(
                        label: Text(order.statusString),
                        backgroundColor: order.statusColor.withOpacity(0.2),
                        labelStyle: TextStyle(color: order.statusColor),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Order date
                  Text(
                    'Date: ${DateFormat('MMM dd, yyyy - HH:mm').format(order.orderDate)}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 12),

                  // Order items
                  const Text(
                    'Items:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...order.items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.quantity}x ${item.foodItem.name}'),
                                Text(
                                    '₱${(item.foodItem.price * item.quantity).toStringAsFixed(2)}'),
                              ],
                            ),
                          ))
                      .toList(),
                  const Divider(),

                  // Order total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₱${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
