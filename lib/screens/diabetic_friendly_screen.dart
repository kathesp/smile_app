import 'package:flutter/material.dart';

class DiabeticFriendlyScreen extends StatelessWidget {
  const DiabeticFriendlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetic Friendly'),
        backgroundColor: const Color(0xFFFEEB50),
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Diabetic Friendly Menu - Coming Soon'),
      ),
    );
  }
}
