import 'package:flutter/material.dart';

class LactoseFreeScreen extends StatelessWidget {
  const LactoseFreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lactose Free'),
        backgroundColor: const Color(0xFFFEEB50),
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Lactose Free Menu - Coming Soon'),
      ),
    );
  }
}
