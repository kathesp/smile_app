import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smile_app/screens/onboarding_screen.dart';
import 'package:smile_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset('assets/SPLASH-SCREEN-ANIMATED.gif'),
      ),
    );
  }
}

class HeartLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Starting point
    path.moveTo(size.width * 0.3, size.height * 0.4);

    // Left curve of heart
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.2,
      size.width * 0.1,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.9,
    );

    // Right curve of heart
    path.cubicTo(
      size.width * 0.9,
      size.height * 0.7,
      size.width * 0.9,
      size.height * 0.2,
      size.width * 0.7,
      size.height * 0.4,
    );

    // Connect to the starting point
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.2,
      size.width * 0.3,
      size.height * 0.4,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
