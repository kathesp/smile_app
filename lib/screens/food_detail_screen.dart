import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import 'profile_screen.dart';
import 'order_screen.dart';
import 'cart_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem foodItem;

  const FoodDetailScreen({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _currentIndex = 1; // Set to 1 for Orders tab

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Content
            CustomScrollView(
              slivers: [
                // App Bar with image
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  backgroundColor: const Color(0xFFFEEB50),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.black),
                      onPressed: () {},
                    ),
                    // Cart icon with counter
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
                        if (cartService.itemCount > 0)
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
                                cartService.itemCount.toString(),
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
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      widget.foodItem.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child:
                                Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Food details
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.foodItem.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₱${widget.foodItem.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          widget.foodItem.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dietary info
                        const Text(
                          'Dietary Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (widget.foodItem.isLowSodium)
                              _buildDietaryChip(
                                  'Low Sodium', Colors.blue.shade100),
                            if (widget.foodItem.isHighProtein)
                              _buildDietaryChip(
                                  'High Protein', Colors.green.shade100),
                            if (widget.foodItem.isDiabeticFriendly)
                              _buildDietaryChip(
                                  'Diabetic Friendly', Colors.orange.shade100),
                            if (widget.foodItem.isLactoseFree)
                              _buildDietaryChip(
                                  'Lactose Free', Colors.purple.shade100),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Allergies
                        if (widget.foodItem.allergies.isNotEmpty) ...[
                          const Text(
                            'Allergens',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.foodItem.allergies
                                .map((allergen) => _buildDietaryChip(
                                    allergen, Colors.red.shade100))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Nutritional info (placeholder)
                        const Text(
                          'Nutritional Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        _buildNutritionRow('Calories', '120 kcal'),
                        _buildNutritionRow('Protein', '5g'),
                        _buildNutritionRow('Carbohydrates', '22g'),
                        _buildNutritionRow('Fat', '3g'),
                        _buildNutritionRow('Sodium', '<12mg'),

                        const SizedBox(height: 80), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Add to cart button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
                child: ElevatedButton(
                  onPressed: () {
                    cartService.addItem(widget.foodItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.foodItem.name} added to cart'),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'VIEW CART',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
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
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
            // Pop back to home
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 1 && Navigator.of(context).canPop()) {
            // Go back to order screen
            Navigator.of(context).pop();
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

  Widget _buildDietaryChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildNutritionRow(String nutrient, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nutrient,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
