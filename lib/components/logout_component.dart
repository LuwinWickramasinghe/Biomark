// lib/components/logout_component.dart

import 'package:flutter/material.dart';
import 'package:biomark/util/database_helper.dart'; // Import the DatabaseHelper
import 'package:biomark/Screens/Login/login_screen.dart'; // Import the LoginScreen

class LogoutComponent extends StatelessWidget {
  static final _dbHelper = DatabaseHelper.instance; // Initialize the database helper

  // Logout function that uses the repository method
  Future<void> _logout(BuildContext context) async {
    try {
      await _dbHelper.clearCache(); // Call the logout method from the repository
      // Replace the current screen with the login screen, removing all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Removes all previous routes from the stack
      );
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error logging out. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () => _logout(context), // Trigger the logout function
    );
  }
}
