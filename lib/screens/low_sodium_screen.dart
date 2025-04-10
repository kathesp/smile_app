import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'order_screen.dart';
import '../services/menu_service.dart';
import 'dietary_screen.dart';

class LowSodiumScreen extends DietaryScreen {
  const LowSodiumScreen({super.key}) : super(categoryName: 'Low Sodium');

  @override
  State<LowSodiumScreen> createState() => _LowSodiumScreenState();
}

class _LowSodiumScreenState extends State<LowSodiumScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  List<String> get categories =>
      MenuService.getSubcategories(widget.categoryName);

  Color get headerColor => const Color(0xFFFEEB50);

  @override
  void initState() {
    super.initState();
    _selectedCategory = MenuService.getSubcategories(widget.categoryName).first;
  }

  List<FoodItem> get filteredItems =>
      MenuService.getItems(widget.categoryName, _selectedCategory)
          .map((item) => FoodItem(
                id: '${widget.categoryName.toLowerCase()}_${item['name'].toLowerCase().replaceAll(' ', '_')}',
                name: item['name'],
                description: item['description'],
                price: item['price'],
                category: _selectedCategory,
                image:
                    'assets/${widget.categoryName.toLowerCase()}/${_selectedCategory.toLowerCase().replaceAll(' ', '_')}.png',
                isLowSodium: widget.categoryName == 'Low Sodium',
                isHighProtein: widget.categoryName == 'High Protein',
                isDiabeticFriendly: widget.categoryName == 'Diabetic Friendly',
                isLactoseFree: widget.categoryName == 'Lactose Free',
                allergies: item['allergies'] != null
                    ? List<String>.from(item['allergies'])
                    : const [],
              ))
          .toList();

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
              color: headerColor, // Yellow header color
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
                        'Low Sodium',
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

            // Category tabs
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              }
                            },
                            backgroundColor: Colors.grey.shade200,
                            selectedColor: headerColor,
                            labelStyle: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.black
                                  : Colors.black54,
                              fontWeight: _selectedCategory == category
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),

            // Food items grid
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(
                      child: Text('No items found for this category'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _buildFoodItemCard(context, item, cartService);
                      },
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
            // Navigate to home
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1 && Navigator.of(context).canPop()) {
            // Go back to order screen
            Navigator.pushReplacementNamed(context, '/order');
          } else if (index == 2) {
            // Navigate to profile screen
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        selectedItemColor: headerColor, // Yellow selected icon
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

  Widget _buildFoodItemCard(
    BuildContext context,
    FoodItem item,
    CartService cartService,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailScreen(foodItem: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.asset(
                    item.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                  // Add to cart button
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: GestureDetector(
                      onTap: () {
                        cartService.addItem(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} added to cart'),
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
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Food details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'P${item.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
