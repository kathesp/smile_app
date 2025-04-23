import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/menu_service.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';

class LactoseFreeScreen extends StatefulWidget {
  const LactoseFreeScreen({Key? key}) : super(key: key);

  @override
  State<LactoseFreeScreen> createState() => _LactoseFreeScreenState();
}

class _LactoseFreeScreenState extends State<LactoseFreeScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;

  List<String> get categories => MenuService.getSubcategories('Lactose Free');

  Color get headerColor =>
      const Color(0xFF9C27B0); // Purple color for lactose free

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        categories.isNotEmpty ? categories.first : 'Morning Offer';
  }

  List<FoodItem> get filteredItems =>
      MenuService.getItems('Lactose Free', _selectedCategory)
          .map((item) => FoodItem(
                id: 'lactose_free_${item['name'].toLowerCase().replaceAll(' ', '_')}',
                name: item['name'],
                description: item['description'],
                price: item['price'],
                category: _selectedCategory,
                image: getImagePathForItem(item['name'], _selectedCategory),
                isLowSodium: false,
                isHighProtein: false,
                isDiabeticFriendly: false,
                isLactoseFree: true,
                allergies: item['allergies'] != null
                    ? List<String>.from(item['allergies'])
                    : const [],
              ))
          .toList();

  String getImagePathForItem(String itemName, String subcategory) {
    // Direct mapping of item names to image file names
    final Map<String, String> imageMap = {
      // Morning Offer
      'Arroz Caldo with Chicken and Malunggay': 'LF-Arroz-Caldo',
      'Boiled Saba + Peanut Butter': 'LF-Boiled-Saba-Peanut-Butter',
      'Ginisang Ampalaya with Egg': 'LF-Ginisang-Ampalaya-Egg',
      'Tortang Talong': 'LF-Tortang-Talong',
      'Soy Milk with Banana or Kamote': 'LF-Soy-Milk-Banana',

      // Lunch Offer
      'Chicken Adobo': 'LF-Chicken-Adobo',
      'Inihaw na Tilapia with Ensaladang Mangga': 'LF-Inihaw-Tilapia-Mangga',
      'Paksiw na Bangus': 'LF-Paksiw-Bangus',
      'Ginisang Upo with Chicken': 'LF-Ginisang-Upo-Chicken',
      'Pork Sinigang': 'LF-Pork-Sinigang',

      // Drinks
      'Soy-based Taho': 'LF-Soy-Taho',
      'Ginger Brew': 'LF-Salabat',
      'Rice Milk Smoothie with Mango': 'LF-Rice-Milk-Smoothie',
      'Coconut Water': 'LF-Coconut-Water',
      'Almond Milk Brew with Table': 'LF-Almond-Milk-Brew',

      // Dinner Offer
      'Laing': 'LF-Laing',
      'Mongo Guisado with Malunggay': 'LF-Mongo-Guisado-Malunggay',
      'Tuna Lumpia': 'LF-Tuna-Lumpia',
      'Stir-fried Gabi and Pechay': 'LF-Stir-Fried-Gabi-Pechay',
      'Adobong Kangkong with Tofu': 'LF-Adobong-Kangkong-Tofu',

      // Additional
      'Kalamay': 'LF-Kalamay',
      'Boiled Cassava': 'LF-Boiled-Cassava',
      'Rice Cakes': 'LF-Rice-Cakes',
      'Fresh Lumpia': 'LF-Fresh-Lumpia',
      'Banana-cue': 'LF-Banana-Cue',
    };

    // Exact match lookup
    if (imageMap.containsKey(itemName)) {
      return 'assets/Lactose-Free/${imageMap[itemName]}.png';
    }

    // Try partial match if exact match not found
    for (var key in imageMap.keys) {
      if (itemName.contains(key) || key.contains(itemName)) {
        return 'assets/Lactose-Free/${imageMap[key]}.png';
      }
    }

    // Fallback to category-based mapping
    Map<String, String> categorySampleImages = {
      'Morning Offer': 'LF-Arroz-Caldo',
      'Lunch Offer': 'LF-Chicken-Adobo',
      'Drinks': 'LF-Soy-Taho',
      'Dinner Offer': 'LF-Laing',
      'Additional': 'LF-Fresh-Lumpia',
    };

    if (categorySampleImages.containsKey(subcategory)) {
      return 'assets/Lactose-Free/${categorySampleImages[subcategory]}.png';
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
        title: const Text('Lactose Free'),
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
              color: const Color(0xFFDDD6F8), // Amber/yellow color
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
                        color: const Color(0xB5A767CC),
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
