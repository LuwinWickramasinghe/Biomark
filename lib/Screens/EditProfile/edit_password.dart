import 'package:biomark/Screens/SubscriptionConfirm/subscribe_successful.dart';
import 'package:biomark/Screens/SubscriptionConfirm/subscribe_unsuccessful.dart';
import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import '../../service/UserService.dart';
import '../../util/hash_password.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final UserService _userService;
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> formData = {
        'email': _passwordController.text,
        'newPassword': hashPassword(_newPasswordController.text),
      };

      try {
        await _userService.updatePassword(formData);
        setState(() {
          isSubscribed = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SubscribeSuccessfulScreen()),
        );
      } catch (e) {
        setState(() {
          isSubscribed = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile.")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SubscribeUnsuccessfulScreen()),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: kPrimaryLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
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
                        labelText: "New Password",
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: "Re-enter New Password",
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
                    const SizedBox(height: defaultPadding * 2),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
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
