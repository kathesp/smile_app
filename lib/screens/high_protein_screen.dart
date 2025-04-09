import 'package:flutter/material.dart';

class HighProteinScreen extends StatelessWidget {
  const HighProteinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Protein'),
        backgroundColor: const Color(0xFFFEEB50),
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('High Protein Menu - Coming Soon'),
      ),
    );
  }
}
