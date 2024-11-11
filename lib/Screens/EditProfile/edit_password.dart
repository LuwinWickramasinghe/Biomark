import 'package:biomark/Screens/SubscriptionConfirm/subscribe_successful.dart';
import 'package:biomark/Screens/SubscriptionConfirm/subscribe_unsuccessful.dart';
import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import '../../service/UserService.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late final UserService _userService;
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect form data
      Map<String, dynamic> formData = {
        'email': _passwordController.text,
        'newPassword': _newPasswordController.text,
      };

      try {
        // Attempt to save form data
        await _userService.saveFormData(formData);
        setState(() {
          isSubscribed = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubscribeSuccessfulScreen()),
        );
      } catch (e) {
        // Handle failure, set isSubscribed to false
        setState(() {
          isSubscribed = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile.")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubscribeUnsuccessfulScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Current Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: "New password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Re-enter new password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text("Save Changes"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
