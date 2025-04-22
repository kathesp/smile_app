import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smile_app/utils/constants.dart';
import 'package:smile_app/screens/login_screen.dart';
import 'package:smile_app/screens/account_information_screen.dart';
import 'package:smile_app/screens/payments_screen.dart';
import 'package:smile_app/screens/address_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Loading...';
  String _userPhone = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          setState(() {
            _userName = userData['name'] ?? 'User';
            _userPhone = userData['phonenum'] ?? '';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile header
                  Container(
                    padding: const EdgeInsets.all(AppSizes.paddingL),
                    color: AppColors.primary,
                    child: Row(
                      children: [
                        // Profile image
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/LOGO.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingL),
                        // User info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.textDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _userPhone,
                                style: AppTextStyles.bodyText2.copyWith(
                                  color: AppColors.textDark.withOpacity(0.7),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile options
                  const SizedBox(height: AppSizes.paddingL),

                  // Account Information
                  _buildProfileOption(
                    context: context,
                    icon: Icons.person,
                    title: 'Account Information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AccountInformationScreen(),
                        ),
                      ).then((_) =>
                          _fetchUserData()); // Refresh data when returning
                    },
                  ),

                  const Divider(height: 1),

                  // Payments
                  _buildProfileOption(
                    context: context,
                    icon: Icons.payment,
                    title: 'Payments',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  // Address
                  _buildProfileOption(
                    context: context,
                    icon: Icons.location_on,
                    title: 'Address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSizes.paddingXL),

                  // Logout button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingL),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showLogoutConfirmation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade100,
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(
        title,
        style: AppTextStyles.bodyText1,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Close dialog
              Navigator.pop(context);

              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();

              // Navigate to login screen
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false, // Remove all previous routes
                );
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
