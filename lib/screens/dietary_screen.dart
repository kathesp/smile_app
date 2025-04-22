import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/menu_service.dart';
import 'cart_screen.dart';

abstract class DietaryScreen extends StatefulWidget {
  final String categoryName;
  const DietaryScreen({super.key, required this.categoryName});
}

mixin DietaryScreenMixin<T extends DietaryScreen> on State<T> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  List<String> get categories;
  Color get headerColor;

  @override
  void initState() {
    super.initState();
    _selectedCategory = MenuService.getSubcategories(widget.categoryName).first;
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final cartItemCount = cartService.itemCount;
    final filteredItems = this.filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header implementation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: headerColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          widget.categoryName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartScreen(),
                              ),
                            ),
                          ),
                          if (cartItemCount > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  cartItemCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Rest of the screen implementation
          ],
        ),
      ),
    );
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
}
