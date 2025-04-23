import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/menu_service.dart';
import 'cart_screen.dart';
import 'food_detail_screen.dart';

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
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: headerColor,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(color: Colors.black, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: _selectedCategory == category,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: headerColor,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
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
                      childAspectRatio: 0.78,
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
    );
  }

  String getImagePathForItem(
    String categoryName,
    String itemName,
    String subcategory,
  ) {
    if (categoryName == 'Low Sodium') {
      // Direct mapping of item names to image file names
      final Map<String, String> imageMap = {
        // Morning Offer
        'Lugaw': 'LS-Lugaw',
        'Pandesal': 'LS-Pandesal',
        'Saging na Saba with Oats': 'LS-Saging-Saba-Oats',
        'Low-sodium Tofu Tokwa with Rice': 'LS-Tokwa-Rice',
        'Kamote and Boiled Egg': 'LS-Kamote-Boiled-Eggs',

        // Lunch Offer
        'Inihaw na Bangus': 'LS-Grilled-Bangus',
        'Pinakbet': 'LS-Pinakbet',
        'Chicken Tinola': 'LS-Chicken-Tinola',
        'Laing': 'LS-Laing',
        'Mongo Guisado': 'LS-Mongo',

        // Drinks
        'Salabat': 'LS-Salabat',
        'Cucumber-infused water': 'LS-Cucumber-Water',
        'Calamansi juice': 'LS-Calamansi-Juice',
        'Unsweetened pandan water': 'LS-Pandan-Water',
        'Boiled corn water': 'LS-Pineapple-Juice',

        // Dinner Offer
        'Pesang Isda': 'LS-Pesang-Isda',
        'Ginisang Upo with Ground Chicken': 'LS-Ginisang-Upo',
        'Sayote with Chicken Breast': 'LS-Sayote-Giniling',
        'Ginisang Ampalaya with Egg': 'LS-Ginisang-Ampalaya',
        'Nilagang Gulay': 'LS-Nilagang-Gulay',

        // Additional
        'Lumpiang Sariwa': 'LS-Lumpia-Sariwa',
        'Kamote-cue': 'LS-Kamote-Cue',
        'Corn on the Cob': 'LS-Corn-on-Cob',
        'Boiled saba banana': 'LS-Boiled-Saba',
        'Steamed okra with calamansi': 'LS-Steamed-Okra',
      };

      // Exact match lookup
      if (imageMap.containsKey(itemName)) {
        return 'assets/Low-Sodium/${imageMap[itemName]}.png';
      }

      // Try partial match if exact match not found
      for (var key in imageMap.keys) {
        if (itemName.contains(key) || key.contains(itemName)) {
          return 'assets/Low-Sodium/${imageMap[key]}.png';
        }
      }

      // Fallback to category-based mapping
      Map<String, String> categorySampleImages = {
        'Morning Offer': 'LS-Lugaw',
        'Lunch Offer': 'LS-Grilled-Bangus',
        'Drinks': 'LS-Salabat',
        'Dinner Offer': 'LS-Pesang-Isda',
        'Additional': 'LS-Lumpia-Sariwa',
      };

      if (categorySampleImages.containsKey(subcategory)) {
        return 'assets/Low-Sodium/${categorySampleImages[subcategory]}.png';
      }

      // Last fallback is app logo
      return 'assets/LOGO.png';
    } else if (categoryName == 'High Protein') {
      // Direct mapping of item names to image file names
      final Map<String, String> imageMap = {
        // Morning Offer
        'Tortang Talong with Ground Chicken': 'HP-Tortang-Talong',
        'Boiled Eggs with Kamote': 'HP-Boiled-Eggs-Kamote',
        'Bangus Belly with Brown Rice': 'HP-Bangus-Belly-Rice',
        'Tokwa\'t Sitaw': 'HP-Tokwa-Sitaw',
        'Chicken Arroz Caldo': 'HP-Chicken Arroz Caldo',

        // Lunch Offer
        'Adobong Manok sa Pula': 'HP-Adobong Manok sa Pula',
        'Ginataang Sitaw at Kalabasa with Lean Pork':
            'HP-Ginataang-Sitaw-Kalabasa',
        'Sinampalukang Manok': 'HP-Sinampalukang-Manok',
        'Inihaw na Tilapia with Tomato-Onion Salad':
            'HP-Inihaw na Tilapia + Salad',
        'Pork Ginisang Repolyo': 'HP-Pork Ginisang Repolyo',

        // Drinks
        'Soy Milk with Banana': 'HP-Soy-Milk',
        'Calamansi Whey Protein Blend': 'HP-Calamansi-Protein-Blend',
        'Malunggay Smoothie': 'HP-Malunggay-Smoothie',
        'Protein-rich lugaw with fish flakes': 'HP-Protein-Lugaw',
        'Peanut-based drink': 'HP-Peanut-Drink',

        // Dinner Offer
        'Chicken Adobo with Quail Eggs': 'HP-Chicken-Adobo',
        'Ginisang Monggo with Malunggay and Tinapa': 'HP-Ginisang-Monggo',
        'Stir-fried Tofu and Ampalaya': 'HP-Stir-Fried-Tofu',
        'Lumpiang Togue': 'HP-Lumpiang-Toge',
        'Beef Tapa': 'HP-Beef-Tapa',

        // Additional
        'Hard-boiled eggs': 'HP-Hard-Boiled-Eggs',
        'Tuna spread in whole wheat pandesal': 'HP-Tuna-Spread-Pandesal',
        'Protein bar with malunggay & oats': 'HP-Protein-Bar',
        'Steamed fish flakes with egg': 'HP-Steamed-Fish-Flakes',
        'Boiled peanuts': 'HP-Boiled-Peanuts',
      };

      // Exact match lookup
      if (imageMap.containsKey(itemName)) {
        return 'assets/High-Protein/${imageMap[itemName]}.png';
      }

      // Try partial match if exact match not found
      for (var key in imageMap.keys) {
        if (itemName.contains(key) || key.contains(itemName)) {
          return 'assets/High-Protein/${imageMap[key]}.png';
        }
      }

      // Fallback to category-based mapping
      Map<String, String> categorySampleImages = {
        'Morning Offer': 'HP-Tortang-Talong',
        'Lunch Offer': 'HP-Adobong-Manok',
        'Drinks': 'HP-Soy-Milk',
        'Dinner Offer': 'HP-Chicken-Adobo',
        'Additional': 'HP-Hard-Boiled-Eggs',
      };

      if (categorySampleImages.containsKey(subcategory)) {
        return 'assets/High-Protein/${categorySampleImages[subcategory]}.png';
      }

      // Last fallback is app logo
      return 'assets/LOGO.png';
    } else {
      // For other categories, just return the logo for now
      return 'assets/LOGO.png';
    }
  }

  List<FoodItem> get filteredItems =>
      MenuService.getItems(widget.categoryName, _selectedCategory)
          .map(
            (item) => FoodItem(
              id: '${widget.categoryName.toLowerCase()}_${item['name'].toLowerCase().replaceAll(' ', '_')}',
              name: item['name'],
              description: item['description'],
              price: item['price'],
              category: _selectedCategory,
              image: getImagePathForItem(
                widget.categoryName,
                item['name'],
                _selectedCategory,
              ),
              isLowSodium: widget.categoryName == 'Low Sodium',
              isHighProtein: widget.categoryName == 'High Protein',
              isDiabeticFriendly: widget.categoryName == 'Diabetic Friendly',
              isLactoseFree: widget.categoryName == 'Lactose Free',
              allergies: item['allergies'] != null
                  ? List<String>.from(item['allergies'])
                  : const [],
            ),
          )
          .toList();

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
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Yellow bottom bar with food name, price and add button
            Container(
              color: const Color(0xFFF7F8D6), // Amber/yellow color
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name and price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                        Text(
                          '₱${item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add button
                  GestureDetector(
                    onTap: () {
                      cartService.addItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} added to cart'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xB5E4CC47),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
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
    );
  }

  // Add a method to log all loaded items for debugging
  void debugMenuItems() {
    final items = MenuService.getItems(widget.categoryName, _selectedCategory);
    print('==== Items for ${widget.categoryName}, ${_selectedCategory} ====');
    for (var item in items) {
      final imagePath = getImagePathForItem(
        widget.categoryName,
        item['name'],
        _selectedCategory,
      );
      print('Item: ${item['name']} -> Image: $imagePath');
    }
    print('==============================================');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Debug menu items when screen loads
    debugMenuItems();
  }
}
