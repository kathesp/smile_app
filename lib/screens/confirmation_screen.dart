import 'package:flutter/material.dart';
import 'package:smile_app/screens/login_screen.dart';
import 'package:smile_app/utils/constants.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 60,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXL),

                // Success message
                const Text(
                  "You've Successfully Registered!",
                  style: AppTextStyles.headline2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.paddingXL),

                // Continue button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false, // Remove all previous routes
                    );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
