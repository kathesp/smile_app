import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smile_app/screens/home_screen.dart';
import 'package:smile_app/screens/signup_screen.dart';
import 'package:smile_app/screens/welcome_screen.dart'; // Import welcome screen
import 'package:smile_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String input = _phoneController.text.trim();
      String password = _passwordController.text.trim();

      try {
        String email = input;

        if (!input.contains('@')) {
          final snapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('phonenum', isEqualTo: input)
              .get();

          if (snapshot.docs.isEmpty) {
            throw FirebaseAuthException(
              code: 'user-not-found',
              message: 'Phone number not found.',
            );
          }

          email = snapshot.docs.first['email'];
        }

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF99D4FF), // Updated background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXL),

                const Text(
                  'Email or Phone Number',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingS),

                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter email or phone number',
                    filled: true,
                    fillColor: Colors.lightBlue.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                      vertical: AppSizes.paddingM,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.paddingL),

                const Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingS),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '********',
                    filled: true,
                    fillColor: Colors.lightBlue.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                      vertical: AppSizes.paddingM,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXL),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

    path.moveTo(size.width * 0.3, size.height * 0.4);

    path.cubicTo(
      size.width * 0.1,
      size.height * 0.2,
      size.width * 0.1,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.9,
    );

    path.cubicTo(
      size.width * 0.9,
      size.height * 0.7,
      size.width * 0.9,
      size.height * 0.2,
      size.width * 0.7,
      size.height * 0.4,
    );

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
