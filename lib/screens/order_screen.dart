import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/order.dart';
import '../services/cart_service.dart';
import 'profile_screen.dart';
import 'low_sodium_screen.dart';
import 'high_protein_screen.dart';
import 'diabetic_friendly_screen.dart';
import 'lactose_free_screen.dart';
import 'order_history_screen.dart';
import 'track_order_screen.dart';
import 'cart_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1; // Set to 1 for Orders tab

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final cartItemCount = cartService.itemCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Yellow header with back, title and cart
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFFFEEB50), // Yellow header color
              child: Column(
                children: [
                  Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const Spacer(),

                      // Title
                      const Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const Spacer(),

                      // Cart button with counter
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart,
                                color: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                          if (cartItemCount > 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cartItemCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  // Search field
                  const SizedBox(height: 16),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for food',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 14),
                        prefixIcon: const Icon(Icons.search,
                            size: 20, color: Colors.grey),
                        suffixIcon: const Icon(Icons.tune,
                            size: 20, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category heading
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Categories grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.0, // Updated to make cards larger
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildCategoryCard(
                            'Low Sodium',
                            'assets/images/low_sodium.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LowSodiumScreen(),
                              ),
                            ),
                          ),
                          _buildCategoryCard(
                            'High Protein',
                            'assets/images/high_protein.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HighProteinScreen(),
                              ),
                            ),
                          ),
                          _buildCategoryCard(
                            'Diabetic Friendly',
                            'assets/images/diabetic_friendly.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DiabeticFriendlyScreen(),
                              ),
                            ),
                          ),
                          _buildCategoryCard(
                            'Lactose Free',
                            'assets/images/lactose_free.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LactoseFreeScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Delivery promotion banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Left side text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Free delivery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'within 20km!',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                    child: const Text(
                                      'Order now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right side image
                            Image.asset(
                              'assets/onboarding1.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // History heading
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // History options
                      Row(
                        children: [
                          // Order History
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderHistoryScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA7D7FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Order\nHistory',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Track Order
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TrackOrderScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA7D7FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Track\nOrder',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
            Navigator.pop(context);
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

  Widget _buildCategoryCard(
      String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFEEB50), // Yellow background as in design
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Top image section
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 60,
                  width: 60,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback icon if image not found
                    IconData iconData;
                    if (title == 'Low Sodium') {
                      iconData = Icons.water_drop_outlined;
                    } else if (title == 'High Protein') {
                      iconData = Icons.fitness_center;
                    } else if (title == 'Diabetic Friendly') {
                      iconData = Icons.no_food;
                    } else {
                      iconData = Icons.no_drinks;
                    }

                    return Icon(iconData, size: 40, color: Colors.grey);
                  },
                ),
              ),
            ),

            // Bottom text section - white card
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      title == 'Low Sodium'
                          ? 'with categories'
                          : title == 'High Protein'
                              ? 'for fitness'
                              : title == 'Diabetic Friendly'
                                  ? 'sugar controlled'
                                  : 'milk free',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
