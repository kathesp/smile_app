import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/order.dart';
import '../services/cart_service.dart';
import 'profile_screen.dart';
import 'order_screen.dart';
import 'confirmation_screen.dart';

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
                                  child: _buildFoodItemImage(item.foodItem),
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
                          // Navigate to confirmation screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmationScreen(
                                order: order,
                                address:
                                    "123 Main St., Barangay San Antonio, Quezon City, Metro Manila", // Default address
                              ),
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

  Widget _buildFoodItemImage(FoodItem foodItem) {
    // For Low Sodium foods, try to use the image from assets/Low-Sodium directory
    if (foodItem.isLowSodium) {
      // Try to extract a matching filename
      String imageName = '';
      String simplifiedName = foodItem.name.split('(')[0].trim();

      // Map of common food names to their image filenames
      final Map<String, String> imageMap = {
        'Lugaw': 'LS-Lugaw',
        'Pandesal': 'LS-Pandesal',
        'Saging na Saba': 'LS-Saging-Saba-Oats',
        'Tofu': 'LS-Tokwa-Rice',
        'Kamote': 'LS-Kamote-Boiled-Eggs',
        'Bangus': 'LS-Grilled-Bangus',
        'Pinakbet': 'LS-Pinakbet',
        'Tinola': 'LS-Chicken-Tinola',
        'Laing': 'LS-Laing',
        'Mongo': 'LS-Mongo',
        'Salabat': 'LS-Salabat',
        'Cucumber': 'LS-Cucumber-Water',
        'Calamansi': 'LS-Calamansi-Juice',
        'Pandan': 'LS-Pandan-Water',
        'Pesang': 'LS-Pesang-Isda',
        'Upo': 'LS-Ginisang-Upo',
        'Sayote': 'LS-Sayote-Giniling',
        'Ampalaya': 'LS-Ginisang-Ampalaya',
        'Nilagang': 'LS-Nilagang-Gulay',
        'Lumpia': 'LS-Lumpia-Sariwa',
        'Corn': 'LS-Corn-on-Cob',
        'Saba': 'LS-Boiled-Saba',
        'Okra': 'LS-Steamed-Okra',
      };

      // Try to find a matching key
      for (var key in imageMap.keys) {
        if (simplifiedName.contains(key)) {
          imageName = imageMap[key]!;
          break;
        }
      }

      // If we found a match, use it
      if (imageName.isNotEmpty) {
        return Image.asset(
          'assets/Low-Sodium/$imageName.png',
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to logo
            return Image.asset(
              'assets/LOGO.png',
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            );
          },
        );
      }
    } else if (foodItem.isHighProtein) {
      // Try to extract a matching filename
      String imageName = '';
      String simplifiedName = foodItem.name.split('(')[0].trim();

      // Map of common food names to their image filenames
      final Map<String, String> imageMap = {
        'Tortang Talong': 'HP-Tortang-Talong',
        'Boiled Eggs': 'HP-Boiled-Eggs-Kamote',
        'Bangus Belly': 'HP-Bangus-Belly-Rice',
        'Tokwa\'t Sitaw': 'HP-Tokwa-Sitaw',
        'Arroz Caldo': 'HP-Chicken Arroz Caldo',
        'Adobong Manok': 'HP-Adobong Manok sa Pula',
        'Ginataang Sitaw': 'HP-Ginataang-Sitaw-Kalabasa',
        'Sinampalukang': 'HP-Sinampalukang-Manok',
        'Tilapia': 'HP-Inihaw na Tilapia + Salad',
        'Repolyo': 'HP-Pork Ginisang Repolyo',
        'Soy Milk': 'HP-Soy-Milk',
        'Whey': 'HP-Calamansi-Protein-Blend',
        'Malunggay': 'HP-Malunggay-Smoothie',
        'Protein-rich lugaw': 'HP-Protein-Lugaw',
        'Peanut-based': 'HP-Peanut-Drink',
        'Chicken Adobo': 'HP-Chicken-Adobo',
        'Monggo': 'HP-Ginisang-Monggo',
        'Tofu and Ampalaya': 'HP-Stir-Fried-Tofu',
        'Lumpiang Togue': 'HP-Lumpiang-Toge',
        'Beef Tapa': 'HP-Beef-Tapa',
        'Hard-boiled': 'HP-Hard-Boiled-Eggs',
        'Tuna spread': 'HP-Tuna-Spread-Pandesal',
        'Protein bar': 'HP-Protein-Bar',
        'fish flakes': 'HP-Steamed-Fish-Flakes',
        'Boiled peanuts': 'HP-Boiled-Peanuts',
      };

      // Try to find a matching key
      for (var key in imageMap.keys) {
        if (simplifiedName.contains(key)) {
          imageName = imageMap[key]!;
          break;
        }
      }

      // If we found a match, use it
      if (imageName.isNotEmpty) {
        return Image.asset(
          'assets/High-Protein/$imageName.png',
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to logo
            return Image.asset(
              'assets/LOGO.png',
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            );
          },
        );
      }
    }

    // For all other cases, try the original image path
    return Image.asset(
      foodItem.image,
      width: 70,
      height: 70,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // If image fails, use the logo
        return Image.asset(
          'assets/LOGO.png',
          width: 70,
          height: 70,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Last resort fallback
            return Container(
              width: 70,
              height: 70,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image, color: Colors.grey),
            );
          },
        );
      },
    );
  }
}
