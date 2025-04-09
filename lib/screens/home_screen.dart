import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';
import 'package:smile_app/screens/profile_screen.dart';
import 'package:smile_app/screens/order_screen.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final cartService = Provider.of<CartService>(context);
    final cartItemCount = cartService.itemCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Yellow Bar with Location and Cart
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFFFEEB50), // Yellow header color
              child: Column(
                children: [
                  // Location and Cart
                  Row(
                    children: [
                      // Location Icon and Text
                      const Icon(
                        Icons.person, // Person icon as in the design
                        size: 22,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 8),

                      // Location Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Quezon City, Philippines',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Cart Button with counter
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                              size: 28,
                            ),
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

                  // Search Field
                  const SizedBox(height: 16),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for services',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Promo Banner
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 120,
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
                                      padding: const EdgeInsets.all(16),
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
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Limited Offers',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '₱200',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
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
                                    child: Image.asset(
                                      'assets/ad-bg.jpg',
                                      height: 120,
                                      fit: BoxFit.cover,
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
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Services Grid - Using design goal style
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
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
                    const SizedBox(height: 20),
                  ],
                ),
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
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        selectedItemColor: const Color(0xFFFEEB50), // Yellow selected icon
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
          color: const Color(0xFFFEEB50), // Yellow background as in design
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Top image section
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  assetPath,
                  height: 60,
                  width: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),

            // Bottom text section - white card
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
