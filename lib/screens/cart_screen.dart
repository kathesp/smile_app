import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/order.dart';
import '../services/cart_service.dart';
import 'profile_screen.dart';
import 'order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final cartItems = cartService.items;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Yellow header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFFFEEB50), // Yellow header color
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const Spacer(),

                  // Title
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const Spacer(),

                  // Clear button
                  TextButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
                            cartService.clear();
                          },
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: cartItems.isEmpty ? Colors.grey : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Food image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item.foodItem.image,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.image,
                                            color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Food info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.foodItem.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₱${item.foodItem.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Quantity control
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () {
                                        cartService
                                            .decreaseQuantity(item.foodItem.id);
                                      },
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        cartService
                                            .increaseQuantity(item.foodItem.id);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Order summary
            if (cartItems.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('₱${cartService.subtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Delivery Fee
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee'),
                        Text('₱${cartService.deliveryFee.toStringAsFixed(2)}'),
                      ],
                    ),
                    const Divider(height: 24),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₱${cartService.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Checkout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final order = cartService.createOrder();
                          // Here you would typically process the order
                          // For now, let's just show a confirmation dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Order Placed!'),
                              content: Text(
                                  'Your order #${order.id} has been placed.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cartService.clear();
                                    Navigator.of(context).pop();
                                    Navigator.pop(
                                        context); // Return to previous screen
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            // Pop back to home
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 1) {
            // Navigate to order screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OrderScreen()),
            );
          } else if (index == 2) {
            // Navigate to profile screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        selectedItemColor: const Color(0xFFFEEB50), // Yellow selected icon
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
