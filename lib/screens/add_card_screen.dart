import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      // In a real app, this would save the card details
      // For now, we'll just go back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Card',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card Type Banner
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C54),
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'CREDIT/DEBIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXL),

                // Card Number Field
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card number',
                    hintText: '0000 0000 0000 0000',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your card number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.paddingL),

                // Expiry Date and CVV Fields
                Row(
                  children: [
                    // Expiry Date Field
                    Expanded(
                      child: TextFormField(
                        controller: _expiryDateController,
                        decoration: const InputDecoration(
                          labelText: 'Expiration date',
                          hintText: 'MM/YY',
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingM),
                    // CVV Field
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: const InputDecoration(
                          labelText: 'Security code',
                          hintText: 'CVV',
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingXL * 2),

                // Save Button
                ElevatedButton(
                  onPressed: _saveCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Save Card'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
