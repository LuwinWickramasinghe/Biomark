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
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _fetchAndAutofillEmail();
  }

  Future<void> _fetchAndAutofillEmail() async {
    String? email = await _userService.getCurrentUserEmail();
    _emailController.text = email;
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect form data
      Map<String, dynamic> formData = {
        'email': _emailController.text,
        'newemail': _newEmailController.text,
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
      } catch (e) {
        // Handle failure, set isSubscribed to false
        setState(() {
          isSubscribed = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile.")),
        );
      }
    }

    if (isSubscribed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubscribeSuccessfulScreen()),
        );
      } else {
        // Failed submission
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubscribeUnsuccessfulScreen()),
        );
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
                  "Change Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
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
