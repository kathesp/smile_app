class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
  final int quantity;
  final bool isLowSodium;
  final bool isHighProtein;
  final bool isDiabeticFriendly;
  final bool isLactoseFree;
  final List<String> allergies;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.quantity = 1,
    this.isLowSodium = false,
    this.isHighProtein = false,
    this.isDiabeticFriendly = false,
    this.isLactoseFree = false,
    this.allergies = const [],
  });

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? image,
    int? quantity,
    bool? isLowSodium,
    bool? isHighProtein,
    bool? isDiabeticFriendly,
    bool? isLactoseFree,
    List<String>? allergies,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      isLowSodium: isLowSodium ?? this.isLowSodium,
      isHighProtein: isHighProtein ?? this.isHighProtein,
      isDiabeticFriendly: isDiabeticFriendly ?? this.isDiabeticFriendly,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      allergies: allergies ?? this.allergies,
    );
  }

  factory FoodItem.fromMap(Map<String, dynamic> data) {
    return FoodItem(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      category: data['category'],
      image: data['image'],
      quantity: data['quantity'] ?? 1,
      isLowSodium: data['isLowSodium'] ?? false,
      isHighProtein: data['isHighProtein'] ?? false,
      isDiabeticFriendly: data['isDiabeticFriendly'] ?? false,
      isLactoseFree: data['isLactoseFree'] ?? false,
      allergies: List<String>.from(data['allergies'] ?? []),
    );
  }
}

// List of sample food items
List<FoodItem> sampleFoodItems = [
  FoodItem(
    id: '1',
    name: 'Lugaw',
    price: 10.0,
    image: 'assets/images/lugaw.jpg',
    category: 'Morning Offer',
    description: 'Traditional Filipino rice porridge with minimal salt.',
    isLowSodium: true,
    allergies: const [],
  ),
  FoodItem(
    id: '2',
    name: 'Pandesal',
    price: 10.0,
    image: 'assets/images/pandesal.jpg',
    category: 'Morning Offer',
    description: 'Filipino bread roll with reduced sodium content.',
    isLowSodium: true,
    allergies: const [],
  ),
  FoodItem(
    id: '3',
    name: 'Saging na Saba with Oats',
    price: 10.0,
    image: 'assets/images/saging_oats.jpg',
    category: 'Morning Offer',
    description: 'Boiled saba banana served with healthy oats.',
    isLowSodium: true,
    isDiabeticFriendly: true,
    allergies: const [],
  ),
  FoodItem(
    id: '4',
    name: 'Tofu Tokwa with Garlic Rice',
    price: 10.0,
    image: 'assets/images/tofu_rice.jpg',
    category: 'Lunch Offer',
    description: 'Fried tofu with low sodium garlic rice.',
    isLowSodium: true,
    isHighProtein: true,
    allergies: const [],
  ),
  FoodItem(
    id: '5',
    name: 'Kamote and Boiled Egg',
    price: 10.0,
    image: 'assets/images/kamote_egg.jpg',
    category: 'Breakfast',
    description: 'Sweet potato with boiled egg, low sodium option.',
    isLowSodium: true,
    allergies: const [],
  ),
  FoodItem(
    id: '6',
    name: 'Vegetable Omelet with Rice',
    price: 10.0,
    image: 'assets/images/veggie_omelet.jpg',
    category: 'Morning Offer',
    description: 'Vegetable omelet with minimal salt, served with plain rice.',
    isLowSodium: true,
    isHighProtein: true,
    allergies: const [],
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
