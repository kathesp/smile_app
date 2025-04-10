import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';
import 'package:smile_app/screens/login_screen.dart';
import 'package:smile_app/screens/account_information_screen.dart';
import 'package:smile_app/screens/payments_screen.dart';
import 'package:smile_app/screens/address_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      body: SingleChildScrollView(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hidethepain Harold',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        'ID username',
                        style: AppTextStyles.bodyText2.copyWith(
                          color: AppColors.textDark.withOpacity(0.7),
                        ),
                      ),
                    ],
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
                    builder: (context) => const AccountInformationScreen(),
                  ),
                );
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
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
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
            onPressed: () {
              // Close dialog
              Navigator.pop(context);

              // Navigate to login screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false, // Remove all previous routes
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
