import 'package:flutter/material.dart';
import '../RecoveryConfirmation/recovery_successful.dart';
import '../RecoveryConfirmation/recovery_unsuccessful.dart';
import 'package:biomark/repository/repository.dart';
import '../../../util/hash_password.dart';

class PasswordResetScreen extends StatefulWidget {
  final String userEmail;

  const PasswordResetScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSuccessful = false;
  final Repository _repository = Repository();

void _resetPassword() async {
  if (_formKey.currentState!.validate()) {
    // Check if the passwords match
    setState(() {
      _isSuccessful = _passwordController.text == _confirmPasswordController.text;
    });

    if (_isSuccessful) {
      // Call FirebaseHelper to update password in Firestore
      String result = await _repository.updatePassword(widget.userEmail, hashPassword(_passwordController.text));

      if (result == 'Password updated successfully') {
        // Navigate to the successful screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RecoverySuccessfulScreen(),
          ),
        );
      } else {
        // Display failure and navigate to unsuccessful screen
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const RecoveryUnsuccessfulScreen(),
          ),
        );
      }
    } else {
      // If passwords don't match, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match! Please try again."),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Reset")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password reset for: ${widget.userEmail}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: "New Password"),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? "Password is required" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                    validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetPassword,
                    child: const Text("Reset Password"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
