import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Account',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
        actions: [
          TextButton(
            onPressed: () {
              // Edit functionality
            },
            child: const Text('Edit'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoField(
              'Full Name',
              'Philippe Troussier',
            ),
            const SizedBox(height: AppSizes.paddingL),
            _buildInfoField(
              'Email Address',
              'troussier@gmail.com',
            ),
            const SizedBox(height: AppSizes.paddingL),
            _buildInfoField(
              'Phone Number',
              '(+1) 6102347905',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyText2,
        ),
        const SizedBox(height: AppSizes.paddingXS),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Text(
            value,
            style: AppTextStyles.bodyText1,
          ),
        ),
      ],
    );
  }
}
