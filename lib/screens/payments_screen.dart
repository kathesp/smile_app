import 'package:flutter/material.dart';
import 'package:smile_app/screens/add_card_screen.dart';
import 'package:smile_app/utils/constants.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded list of cards
    final List<Map<String, String>> cards = [
      {
        'type': 'VISA',
        'number': '**** 7811',
      },
      {
        'type': 'VISA',
        'number': '**** 3621',
      },
      {
        'type': 'VISA',
        'number': '**** 4211',
      },
      {
        'type': 'VISA',
        'number': '**** 8241',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cards',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        itemCount: cards.length + 1, // +1 for the add card option
        itemBuilder: (context, index) {
          if (index == cards.length) {
            // Add new card option
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: AppSizes.paddingS),
              leading: const CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.textDark),
              ),
              title: const Text('Add debit/credit card'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCardScreen(),
                  ),
                );
              },
            );
          }

          // Card item
          return Container(
            margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C54),
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppSizes.paddingM),
              title: Text(
                cards[index]['type']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                cards[index]['number']!,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              leading: const Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 32,
              ),
            ),
          );
        },
      ),
    );
  }
}
