import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String _currentAddress = '9185 Mayflower Drive Atlanta';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addNewAddress() {
    // In a real app, this would open a form to add a new address
    // For now, we'll just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add address functionality coming soon!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Address',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter a new address',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _addNewAddress();
                }
              },
            ),
            const SizedBox(height: AppSizes.paddingL),

            // Current Address Title
            const Text(
              'Current Address:',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: AppSizes.paddingM),

            // Current Address Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingL),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 30,
                  ),
                  const SizedBox(width: AppSizes.paddingM),
                  Text(
                    _currentAddress,
                    style: AppTextStyles.bodyText1,
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
