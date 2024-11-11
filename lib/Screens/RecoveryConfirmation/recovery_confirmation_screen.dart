import 'package:flutter/material.dart';
import '../RecoveryConfirmation/recovery_successful.dart';
import '../RecoveryConfirmation/recovery_unsuccessful.dart';
import 'package:biomark/repository/repository.dart';

class PasswordResetScreen extends StatefulWidget {
  final String userEmail;

  const PasswordResetScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isSuccessful = false;
  final Repository _repository = Repository();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      // Check if the passwords match
      setState(() {
        _isSuccessful =
            _passwordController.text == _confirmPasswordController.text;
      });

      if (_isSuccessful) {
        print(_passwordController.text);
        // Call FirebaseHelper to update password in Firestore
        String result = await _repository.updatePassword(
            widget.userEmail, _passwordController.text);
        print(result);
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
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Create New Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 1.5),

                    // New Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "New Password",
                        labelStyle: TextStyle(fontFamily: 'Montserrat'),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: defaultPadding),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(fontFamily: 'Montserrat'),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: defaultPadding * 2),

                    // Confirm Reset Button
                    Center(
                      child: ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          elevation: 12,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Text(
                          "Confirm Reset",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
