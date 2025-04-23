import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/menu_service.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';

class HighProteinScreen extends StatefulWidget {
  const HighProteinScreen({Key? key}) : super(key: key);

  @override
  State<HighProteinScreen> createState() => _HighProteinScreenState();
}

class _HighProteinScreenState extends State<HighProteinScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  final String categoryName = 'High Protein';

  List<String> get categories => MenuService.getSubcategories(categoryName);

  Color get headerColor =>
      const Color(0xFF4CAF50); // Green color for high protein

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        categories.isNotEmpty ? categories.first : 'Morning Offer';
  }

  List<FoodItem> get filteredItems =>
      MenuService.getItems(categoryName, _selectedCategory)
          .map((item) => FoodItem(
                id: 'high_protein_${item['name'].toLowerCase().replaceAll(' ', '_')}',
                name: item['name'],
                description: item['description'],
                price: item['price'],
                category: _selectedCategory,
                image: getImagePathForItem(item['name'], _selectedCategory),
                isLowSodium: false,
                isHighProtein: true,
                isDiabeticFriendly: false,
                isLactoseFree: false,
                allergies: item['allergies'] != null
                    ? List<String>.from(item['allergies'])
                    : const [],
              ))
          .toList();

  String getImagePathForItem(String itemName, String subcategory) {
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
      'Lunch Offer': 'HP-Adobong Manok sa Pula',
      'Drinks': 'HP-Soy-Milk',
      'Dinner Offer': 'HP-Chicken-Adobo',
      'Additional': 'HP-Hard-Boiled-Eggs',
    };

    if (categorySampleImages.containsKey(subcategory)) {
      return 'assets/High-Protein/${categorySampleImages[subcategory]}.png';
    }

    // Last fallback is app logo
    return 'assets/LOGO.png';
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final cartItemCount = cartService.itemCount;
    final items = filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('High Protein'),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
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
                                ? Colors.white
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
            child: items.isEmpty
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
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildFoodItemCard(context, item, cartService);
                    },
                  ),
          ),
        ],
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
          } else if (index == 1) {
            // Navigate to orders
            Navigator.pushReplacementNamed(context, '/order');
          } else if (index == 2) {
            // Navigate to profile
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        selectedItemColor: headerColor,
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
              color: const Color(0xFFD6F8D7), // Amber/yellow color
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
                        color: const Color(0xB567CC67),
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
}
