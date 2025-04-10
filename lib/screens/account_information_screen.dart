import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_app/utils/constants.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  String? _fullName;
  String? _email;
  String? _phone;

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final uid = user.uid;

      final docSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      setState(() {
        _email = user.email;
        _fullName = docSnapshot['name'] ?? '';
        _phone = docSnapshot['phonenum'].toString();

        // Set controllers for editing
        _nameController.text = _fullName!;
        _emailController.text = _email!;
        _phoneController.text = _phone!;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      // Update email in Firebase Auth (if changed)
      if (_emailController.text.trim() != _email) {
        await user.updateEmail(_emailController.text.trim());
      }

      // Update Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': _nameController.text.trim(),
        'phonenum': _phoneController.text.trim(),
      });

      setState(() {
        _fullName = _nameController.text.trim();
        _email = _emailController.text.trim();
        _phone = _phoneController.text.trim();
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating account: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Account',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(_isEditing ? 'Cancel' : 'Edit'),
          ),
        ],
      ),
      body: _isEditing ? _buildEditForm() : _buildDisplay(),
    );
  }

  Widget _buildDisplay() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoField('Full Name', _fullName ?? 'Loading...'),
          const SizedBox(height: AppSizes.paddingL),
          _buildInfoField('Email Address', _email ?? 'Loading...'),
          const SizedBox(height: AppSizes.paddingL),
          _buildInfoField('Phone Number', _phone ?? 'Loading...'),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildEditableField('Full Name', _nameController),
            const SizedBox(height: AppSizes.paddingL),
            _buildEditableField('Email Address', _emailController,
                isEmail: true),
            const SizedBox(height: AppSizes.paddingL),
            _buildEditableField('Phone Number', _phoneController,
                isPhone: true),
            const SizedBox(height: AppSizes.paddingL),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyText2),
        const SizedBox(height: AppSizes.paddingXS),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Text(value, style: AppTextStyles.bodyText1),
        ),
      ],
    );
  }

  Widget _buildEditableField(
      String label,
      TextEditingController controller, {
        bool isEmail = false,
        bool isPhone = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyText2),
        const SizedBox(height: AppSizes.paddingXS),
        TextFormField(
          controller: controller,
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            if (isEmail && !value.contains('@')) {
              return 'Enter a valid email';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
