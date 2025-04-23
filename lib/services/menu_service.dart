import 'dart:convert';

class DietaryCategory {
  final String name;
  final Map<String, List<Map<String, dynamic>>> subcategories;

  DietaryCategory(this.name, this.subcategories);
}

class MenuService {
  static final List<DietaryCategory> categories = _parseMenuData('''
🧂 Low Sodium (Filipino Meals)
Morning Offer
Lugaw (plain rice porridge, with low-sodium chicken broth) – ₱99
Pandesal (unsalted, paired with scrambled egg whites) – ₱99
Saging na Saba with Oats – ₱99
Low-sodium Tofu Tokwa with Rice – ₱99
Kamote and Boiled Egg – ₱99

Lunch Offer
Inihaw na Bangus (grilled milkfish, no added salt, stuffed with tomatoes and onions) – ₱99
Pinakbet (without bagoong; seasoned with garlic and herbs) – ₱99
Chicken Tinola (low-sodium broth, with malunggay and green papaya) – ₱99
Laing (no bagoong; slow-cooked gabi leaves with coconut milk) – ₱99
Mongo Guisado (with ampalaya and without salted fish) – ₱99

Drinks
Salabat (ginger tea) – ₱99
Cucumber-infused water – ₱99
Calamansi juice (unsweetened) – ₱99
Unsweetened pandan water – ₱99
Boiled corn water (mild and fiber-rich) – ₱99

Dinner Offer
Pesang Isda (light fish stew with pechay) – ₱99
Ginisang Upo with Ground Chicken – ₱99
Sayote with Chicken Breast – ₱99
Ginisang Ampalaya with Egg (rinsed well to reduce bitterness) – ₱99
Nilagang Gulay (mixed vegetables in light broth) – ₱99

Additional
Lumpiang Sariwa (no sauce or low-sodium peanut dressing) – ₱99
Kamote-cue (no sugar coating) – ₱99
Corn on the Cob (boiled, unsalted) – ₱99
Boiled saba banana – ₱99
Steamed okra with calamansi – ₱99

💪 High Protein (Filipino Meals)
Morning Offer
Tortang Talong with Ground Chicken – ₱99
Boiled Eggs with Kamote – ₱99
Bangus Belly with Brown Rice – ₱99
Tokwa't Sitaw – ₱99
Chicken Arroz Caldo (with malunggay) – ₱99

Lunch Offer
Adobong Manok sa Pula (without soy sauce, using annatto and vinegar) – ₱99
Ginataang Sitaw at Kalabasa with Lean Pork – ₱99
Sinampalukang Manok – ₱99
Inihaw na Tilapia with Tomato-Onion Salad – ₱99
Pork Ginisang Repolyo – ₱99

Drinks
Soy Milk with Banana – ₱99
Calamansi Whey Protein Blend – ₱99
Malunggay Smoothie (dairy-free) – ₱99
Protein-rich lugaw with fish flakes – ₱99
Peanut-based drink (low sugar) – ₱99

Dinner Offer
Chicken Adobo with Quail Eggs (light version) – ₱99
Ginisang Monggo with Malunggay and Tinapa (moderate) – ₱99
Stir-fried Tofu and Ampalaya – ₱99
Lumpiang Togue (with lean ground pork and tofu) – ₱99
Beef Tapa (low-sodium marinade) – ₱99

Additional
Hard-boiled eggs – ₱99
Tuna spread in whole wheat pandesal – ₱99
Protein bar with malunggay & oats (homemade) – ₱99
Steamed fish flakes with egg – ₱99
Boiled peanuts – ₱99

🍠 Diabetic Friendly (Filipino Meals)
Morning Offer
Lugaw with Egg (no sugar, low rice portion) – ₱99
Boiled Kamote or Saba with Egg – ₱99
Oatmeal Champorado with Tablea (no sugar, with chia seeds) – ₱99
Amplaya Omelet – ₱99
Rice + Tofu + Sitaw stir-fry – ₱99

Lunch Offer
Ginisang Kalabasa with Malunggay and Tofu – ₱99
Grilled Fish with Ensaladang Talong – ₱99
Sinampalukang Manok (no sugar, with vegetables) – ₱99
Chicken Tinola with Sayote – ₱99
Laing with brown rice (portion-controlled) – ₱99

Drinks
Salabat with Stevia – ₱99
Unsweetened Soy Milk – ₱99
Pandan Tea – ₱99
Lemongrass Water – ₱99
Low-sugar Buko Juice – ₱99

Dinner Offer
Pesang Isda with Sayote and Pechay – ₱99
Tofu and Ampalaya Stir Fry – ₱99
Mongo with Malunggay and Sliced Egg – ₱99
Grilled Chicken Inasal (no sugar in marinade) – ₱99
Chopsuey with Lean Pork – ₱99

Additional
Unsweetened Oat Balls (w/ coconut) – ₱99
Boiled Corn (portion controlled) – ₱99
Fruit slices (apple, papaya) – ₱99
Low-carb Pichi-Pichi (made with Stevia) – ₱99
Boiled Peanuts – ₱99

🥛 Lactose Free (Filipino Meals)
Morning Offer
Arroz Caldo with Chicken and Malunggay (no milk) – ₱99
Boiled Saba + Peanut Butter (dairy-free) – ₱99
Ginisang Ampalaya with Egg – ₱99
Tortang Talong (no cheese or milk) – ₱99
Soy Milk with Banana or Kamote – ₱99

Lunch Offer
Chicken Adobo (no cream, no dairy) – ₱99
Inihaw na Tilapia with Ensaladang Mangga – ₱99
Paksiw na Bangus – ₱99
Ginisang Upo with Chicken – ₱99
Pork Sinigang (no dairy) – ₱99

Drinks
Soy-based Taho (no syrup) – ₱99
Ginger Brew (Salabat) – ₱99
Rice Milk Smoothie with Mango – ₱99
Coconut Water – ₱99
Almond Milk Brew with Tablea – ₱99

Dinner Offer
Laing (check label for no evaporated milk) – ₱99
Mongo Guisado with Malunggay – ₱99
Tuna Lumpia (no cheese) – ₱99
Stir-fried Gabi and Pechay – ₱99
Adobong Kangkong with Tofu – ₱99

Additional
Kalamay (no dairy version) – ₱99
Boiled Cassava – ₱99
Rice Cakes (no dairy) – ₱99
Fresh Lumpia (no cheese or creamy sauce) – ₱99
Banana-cue (no caramel coating) – ₱99
''');

  static List<DietaryCategory> _parseMenuData(String data) {
    final categories = <DietaryCategory>[];
    DietaryCategory? currentCategory;
    String? currentSubcategory;

    final priceRegex = RegExp(r'– ₱(\d+)');

    for (var line in data.split('\n')) {
      line = line.trim();
      if (line.isEmpty) continue;

      if (line.startsWith('🧂') ||
          line.startsWith('💪') ||
          line.startsWith('🍠') ||
          line.startsWith('🥛')) {
        // New category
        final name = line.substring(2).split('(')[0].trim();
        currentCategory = DietaryCategory(name, {});
        categories.add(currentCategory!);
        currentSubcategory = null;
      } else if (line == 'Morning Offer' ||
          line == 'Lunch Offer' ||
          line == 'Dinner Offer' ||
          line == 'Drinks' ||
          line == 'Additional') {
        // Subcategory
        currentSubcategory = line;
        currentCategory?.subcategories[currentSubcategory!] = [];
      } else if (currentSubcategory != null) {
        // Item
        final priceMatch = priceRegex.firstMatch(line);
        final price = priceMatch?.group(1) ?? '99';

        String name = line;
        String description = '';

        if (line.contains('(') && line.contains(')')) {
          name = line.split('(')[0].trim();
          if (name.endsWith('–')) {
            name = name.substring(0, name.length - 1).trim();
          }

          description =
              line.substring(line.indexOf('(') + 1, line.indexOf(')'));
        } else if (line.contains('–')) {
          name = line.split('–')[0].trim();
        }

        currentCategory?.subcategories[currentSubcategory!]?.add({
          'name': name,
          'price': double.parse(price),
          'description': description,
          'allergies': <String>[],
        });
      }
    }
    return categories;
  }

  static List<String> getSubcategories(String categoryName) {
    final category = categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => DietaryCategory(categoryName, {}),
    );
    return category.subcategories.keys.toList();
  }

  static List<Map<String, dynamic>> getItems(
      String categoryName, String subcategory) {
    final category = categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => DietaryCategory(categoryName, {}),
    );
    final items = category.subcategories[subcategory] ?? [];

    // Debug print to see exactly what items are available
    if (categoryName == 'Low Sodium') {
      print(
          'DEBUG MenuService - Requested items for $categoryName, $subcategory:');
      for (var item in items) {
        print('  - ${item['name']}');
      }
    }

    return items;
  }
}
