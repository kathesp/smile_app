import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_app/services/cart_service.dart';
import 'package:smile_app/utils/constants.dart';
import 'package:smile_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyAk5F1RYDJKwKs9eb4oL-_Il3Aa3HXdxIU",
          authDomain: "smile-f079e.firebaseapp.com",
          projectId: "smile-f079e",
          storageBucket: "smile-f079e.appspot.com",
          messagingSenderId: "615138744374",
          appId: "1:615138744374:web:d92457c501566346ffe097",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    runApp(const MyApp());
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: MaterialApp(
        title: 'Smile App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          textTheme: const TextTheme(
            displayLarge: AppTextStyles.headline1,
            displayMedium: AppTextStyles.headline2,
            displaySmall: AppTextStyles.headline3,
            bodyLarge: AppTextStyles.bodyText1,
            bodyMedium: AppTextStyles.bodyText2,
            labelLarge: AppTextStyles.button,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
