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
  int _quantity = 1;

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
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              '₱${widget.foodItem.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          widget.foodItem.description,
                          style: Theme.of(context).textTheme.bodyMedium,
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

                        _buildNutritionInfo(),

                        const SizedBox(height: 24),

                        _buildQuantitySelector(),

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
                child: _buildAddToCartButton(context),
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

  Widget _buildNutritionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutritional Information',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const NutritionRow(label: 'Calories', value: '250 kcal'),
        const NutritionRow(label: 'Protein', value: '20g'),
        const NutritionRow(label: 'Carbs', value: '35g'),
        const NutritionRow(label: 'Fat', value: '8g'),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        Text('Quantity:', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () =>
              setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
        ),
        Text('$_quantity', style: Theme.of(context).textTheme.titleMedium),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _quantity++),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFEEB50),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          final cartService = Provider.of<CartService>(context, listen: false);
          final itemToAdd = widget.foodItem.copyWith(quantity: _quantity);
          cartService.addItem(itemToAdd);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added $_quantity ${widget.foodItem.name} to cart'),
              action: SnackBarAction(
                label: 'VIEW CART',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartScreen())),
              ),
            ),
          );
        },
        child: const Text('ADD TO CART', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class NutritionRow extends StatelessWidget {
  final String label;
  final String value;

  const NutritionRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
