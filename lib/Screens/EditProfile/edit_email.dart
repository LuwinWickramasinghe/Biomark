import 'package:biomark/Screens/SubscriptionConfirm/subscribe_successful.dart';
import 'package:biomark/Screens/SubscriptionConfirm/subscribe_unsuccessful.dart';
import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import '../../service/UserService.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();

  late final UserService _userService;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _fetchAndAutofillEmail();
  }

  Future<void> _fetchAndAutofillEmail() async {
    String? email = await _userService.getCurrentUserEmail();
    setState(() {
      _emailController.text = email ?? '';
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> formData = {
        'oldemail': _emailController.text,
        'email': _newEmailController.text,
      };

      try {
        // Attempt to save form data
        await _userService.updateEmail(formData);
        setState(() {
          isSubmitted = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
      } catch (e) {
        setState(() {
          isSubmitted = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile.")),
        );
      }
    }

    if (isSubmitted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SubscribeSuccessfulScreen()),
      );
    } else {
      // Failed submission
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SubscribeUnsuccessfulScreen()),
      );
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
                      "Change Email",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Current Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _newEmailController,
                      decoration: const InputDecoration(
                        labelText: "New Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new email';
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
