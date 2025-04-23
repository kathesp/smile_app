import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/menu_service.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';

class DiabeticFriendlyScreen extends StatefulWidget {
  const DiabeticFriendlyScreen({Key? key}) : super(key: key);

  @override
  State<DiabeticFriendlyScreen> createState() => _DiabeticFriendlyScreenState();
}

class _DiabeticFriendlyScreenState extends State<DiabeticFriendlyScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  List<String> get categories =>
      MenuService.getSubcategories('Diabetic Friendly');

  Color get headerColor =>
      const Color(0xFFFF9800); // Orange color for diabetic friendly

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        categories.isNotEmpty ? categories.first : 'Morning Offer';
  }

  List<FoodItem> get filteredItems =>
      MenuService.getItems('Diabetic Friendly', _selectedCategory)
          .map((item) => FoodItem(
                id: 'diabetic_friendly_${item['name'].toLowerCase().replaceAll(' ', '_')}',
                name: item['name'],
                description: item['description'],
                price: item['price'],
                category: _selectedCategory,
                image: getImagePathForItem(item['name'], _selectedCategory),
                isLowSodium: false,
                isHighProtein: false,
                isDiabeticFriendly: true,
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
      'Lugaw with Egg': 'DF-Lugaw-Egg',
      'Boiled Kamote or Saba with Egg': 'DF-Boiled-Kamote-Saba',
      'Oatmeal Champorado with Tablea': 'DF-Oatmeal-Champorado',
      'Amplaya Omelet': 'DF-Ampalaya-Omelette',
      'Rice + Tofu + Sitaw stir-fry': 'DF-Rice-Tofu-Sitaw',

      // Lunch Offer
      'Ginisang Kalabasa with Malunggay and Tofu': 'DF-Kalabasa-Malunggay-Tofu',
      'Grilled Fish with Ensaladang Talong': 'DF-Grilled-Fish-Talong',
      'Sinampalukang Manok': 'DF-Sinampalukang-Manok',
      'Chicken Tinola with Sayote': 'DF-Chicken-Tinola-Sayote',
      'Laing with brown rice': 'DF-Laing-Brown-Rice',

      // Drinks
      'Salabat with Stevia': 'DF-Salabat-Stevia',
      'Unsweetened Soy Milk': 'DF-Unsweetened-Soy-Milk',
      'Pandan Tea': 'DF-Pandan-Tea',
      'Lemongrass Water': 'DF-Lemongrass-Water',
      'Low-sugar Buko Juice': 'DF-Low-Sugar-Buko-Juice',

      // Dinner Offer
      'Pesang Isda with Sayote and Pechay': 'DF-Pesang-Isda',
      'Tofu and Ampalaya Stir Fry': 'DF-Tofu-Ampalaya-Stir-Fry',
      'Mongo with Malunggay and Sliced Egg': 'DF-Mongo-Malunggay-Egg',
      'Grilled Chicken Inasal': 'DF-Chicken-Inasal',
      'Chopsuey with Lean Pork': 'DF-Chopsuey-Lean-Pork',

      // Additional
      'Unsweetened Oat Balls': 'DF-Oat-Balls',
      'Boiled Corn': 'DF-Boiled-Corn',
      'Fruit slices': 'DF-Fruit-Slices',
      'Low-carb Pichi-Pichi': 'DF-Low-Carb-Pichi-Pichi',
      'Boiled Peanuts': 'DF-Boiled-Peanuts',
    };

    // Exact match lookup
    if (imageMap.containsKey(itemName)) {
      return 'assets/Diabetic-Friendly/${imageMap[itemName]}.png';
    }

    // Try partial match if exact match not found
    for (var key in imageMap.keys) {
      if (itemName.contains(key) || key.contains(itemName)) {
        return 'assets/Diabetic-Friendly/${imageMap[key]}.png';
      }
    }

    // Fallback to category-based mapping
    Map<String, String> categorySampleImages = {
      'Morning Offer': 'DF-Ampalaya-Omelette',
      'Lunch Offer': 'DF-Grilled-Fish-Talong',
      'Drinks': 'DF-Pandan-Tea',
      'Dinner Offer': 'DF-Pesang-Isda',
      'Additional': 'DF-Fruit-Slices',
    };

    if (categorySampleImages.containsKey(subcategory)) {
      return 'assets/Diabetic-Friendly/${categorySampleImages[subcategory]}.png';
    }

    // Last fallback is app logo
    return 'assets/LOGO.png';
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final cartItemCount = cartService.itemCount;
    final filteredItems = this.filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Diabetic Friendly'),
        backgroundColor: headerColor,
        foregroundColor: Colors.black,
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
              color: const Color(0x64FF9902), // Amber/yellow color
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
                        color: const Color(0xFFD88305),
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
