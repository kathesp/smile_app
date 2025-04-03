import 'package:flutter/material.dart';
import 'package:smile_app/screens/login_screen.dart';
import 'package:smile_app/screens/signup_screen.dart';
import 'package:smile_app/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Logo
              Center(
                child: Image.asset(
                  'assets/LOGO.png',
                  width: 350,
                  height: 350,
                ),
              ),
              const Spacer(flex: 3),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade200,
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    ),
                  ),
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey, width: 1),
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    ),
                  ),
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
