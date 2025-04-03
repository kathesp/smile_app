import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';
import 'package:smile_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartItemCount = 0;
  int _currentIndex = 0;
  int _currentBannerIndex = 0;

  final List<String> _serviceNames = [
    'Order',
    'Medical Support',
    'Emergency Hotline',
    'Meal Plan',
  ];

  final List<String> _serviceDescriptions = [
    'with categories',
    'monitor health',
    'assistance',
    'by dietitians',
  ];

  final List<String> _serviceAssets = [
    'assets/order-icon.png',
    'assets/medical-support-icon.png',
    'assets/emergency-hotline-icon.png',
    'assets/meal-plan-icon.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEB50), // Make the background yellow
      body: SafeArea(
        top: false, // Allow content to extend behind the status bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar with Location and Cart
            Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 40, bottom: 12),
              color: const Color(0xFFFEEB50), // Yellow header color
              child: Row(
                children: [
                  // Location Icon and Text
                  const Icon(
                    Icons.location_on,
                    size: 22,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Quezon City, Philippines',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Cart Button
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.black87),
                        onPressed: () {
                          // Navigate to cart screen
                        },
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '0',
                            style: TextStyle(
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
            ),

            // Remainder of the screen is white with rounded corners
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Field
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for services',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ),

                      // Promo Banner
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFF81D4FA), // Light blue background
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    // Promo Text
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Experience',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Limited Offers',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '₱200',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Food Image - Fixed width to prevent overflow
                                    SizedBox(
                                      width: 160,
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'assets/ad-bg.jpg',
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Banner Indicators
                                Positioned(
                                  bottom: 8,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      5,
                                      (index) => Container(
                                        width: 8,
                                        height: 2,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        decoration: BoxDecoration(
                                          color: index == _currentBannerIndex
                                              ? Colors.blue
                                              : Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Services Title
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Services Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return _buildServiceCard(
                              assetPath: _serviceAssets[index],
                              serviceName: _serviceNames[index],
                              description: _serviceDescriptions[index],
                              onTap: () {
                                // Handle service tap
                                if (index == 0) {
                                  _navigateToOrderScreen();
                                }
                              },
                            );
                          },
                        ),
                      ),

                      // Add some bottom padding
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.circle, isSelected: false),
              _buildNavItem(1, Icons.file_copy_outlined, isSelected: false),
              _buildNavItem(2, Icons.access_time, isSelected: false),
              _buildNavItem(3, Icons.person_outline, isSelected: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        // Handle navigation to profile screen
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFFEEB50) : Colors.transparent,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
          size: isSelected ? 20 : 22,
        ),
      ),
    );
  }

  void _navigateToOrderScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderScreen(),
      ),
    );
  }

  Widget _buildServiceCard({
    required String assetPath,
    required String serviceName,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              assetPath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 4),
            Text(
              serviceName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _cartItemCount = 2;
  int _currentIndex = 1;

  final List<String> _categories = [
    'Low Sodium',
    'High Protein',
    'Diabetic Friendly',
    'Lactose Free',
  ];

  final List<IconData> _categoryIcons = [
    Icons.water_drop_outlined,
    Icons.fitness_center,
    Icons.health_and_safety_outlined,
    Icons.no_drinks,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEB50), // Yellow background
      body: SafeArea(
        top: false, // Allow content to extend behind the status bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button, title and cart
            Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 40, bottom: 12),
              color: const Color(0xFFFEEB50), // Yellow header color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, size: 24),
                        onPressed: () {
                          // Navigate to cart
                        },
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _cartItemCount.toString(),
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
            ),

            // Content - white background with rounded corners
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Field
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Search Box
                            Expanded(
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search for food',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade500),
                                    prefixIcon: const Icon(Icons.search,
                                        color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Filter Button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.tune),
                                onPressed: () {
                                  // Show filter options
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Categories Label
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Categories Grid
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryCard(
                              category: _categories[index],
                              icon: _categoryIcons[index],
                              onTap: () {
                                // Handle category selection
                              },
                            );
                          },
                        ),
                      ),

                      // Free Delivery Banner
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Free delivery',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'within 20km!',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle order now button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                child: const Text('Order now'),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/order-icon.png',
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // History Label
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // History Items
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildHistoryItem(
                                title: 'Order History',
                                iconData: Icons.shopping_cart,
                                color: Colors.blue,
                                onTap: () {
                                  // Navigate to order history
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildHistoryItem(
                                title: 'Track Order',
                                iconData: Icons.local_shipping,
                                color: Colors.blue,
                                onTap: () {
                                  // Navigate to track order
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.circle, false, onTap: () {
                Navigator.pop(context);
              }),
              _buildNavItem(1, Icons.file_copy_outlined, true),
              _buildNavItem(2, Icons.access_time, false),
              _buildNavItem(3, Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, bool isSelected,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFFEEB50) : Colors.transparent,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
          size: isSelected ? 20 : 22,
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String category,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: Colors.black87),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String title,
    required IconData iconData,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
