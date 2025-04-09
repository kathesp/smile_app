class FoodItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final List<String> allergies;
  final bool isLowSodium;
  final bool isHighProtein;
  final bool isDiabeticFriendly;
  final bool isLactoseFree;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.description = '',
    this.allergies = const [],
    this.isLowSodium = false,
    this.isHighProtein = false,
    this.isDiabeticFriendly = false,
    this.isLactoseFree = false,
  });
}

// List of sample food items
List<FoodItem> sampleFoodItems = [
  FoodItem(
    id: '1',
    name: 'Lugaw',
    price: 10.0,
    image: 'assets/images/lugaw.jpg',
    category: 'Morning Offer',
    isLowSodium: true,
    description: 'Traditional Filipino rice porridge with minimal salt.',
  ),
  FoodItem(
    id: '2',
    name: 'Pandesal',
    price: 10.0,
    image: 'assets/images/pandesal.jpg',
    category: 'Morning Offer',
    isLowSodium: true,
    description: 'Filipino bread roll with reduced sodium content.',
  ),
  FoodItem(
    id: '3',
    name: 'Saging na Saba with Oats',
    price: 10.0,
    image: 'assets/images/saging_oats.jpg',
    category: 'Morning Offer',
    isLowSodium: true,
    isDiabeticFriendly: true,
    description: 'Boiled saba banana served with healthy oats.',
  ),
  FoodItem(
    id: '4',
    name: 'Tofu Tokwa with Garlic Rice',
    price: 10.0,
    image: 'assets/images/tofu_rice.jpg',
    category: 'Lunch Offer',
    isLowSodium: true,
    isHighProtein: true,
    description: 'Fried tofu with low sodium garlic rice.',
  ),
  FoodItem(
    id: '5',
    name: 'Kamote and Boiled Egg',
    price: 10.0,
    image: 'assets/images/kamote_egg.jpg',
    category: 'Breakfast',
    isLowSodium: true,
    description: 'Sweet potato with boiled egg, low sodium option.',
  ),
  FoodItem(
    id: '6',
    name: 'Vegetable Omelet with Rice',
    price: 10.0,
    image: 'assets/images/veggie_omelet.jpg',
    category: 'Morning Offer',
    isLowSodium: true,
    isHighProtein: true,
    description: 'Vegetable omelet with minimal salt, served with plain rice.',
  ),
];

// Get food items by category
List<FoodItem> getFoodItemsByCategory(String category) {
  return sampleFoodItems.where((item) => item.category == category).toList();
}

// Get food items by dietary needs
List<FoodItem> getLowSodiumItems() {
  return sampleFoodItems.where((item) => item.isLowSodium).toList();
}

List<FoodItem> getHighProteinItems() {
  return sampleFoodItems.where((item) => item.isHighProtein).toList();
}

List<FoodItem> getDiabeticFriendlyItems() {
  return sampleFoodItems.where((item) => item.isDiabeticFriendly).toList();
}

List<FoodItem> getLactoseFreeItems() {
  return sampleFoodItems.where((item) => item.isLactoseFree).toList();
}
