import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import '../../service/UserService.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  late final UserService _userService;

  @override
  void initState() {
    print('came here1');
    super.initState();
    print('came here2');
    _userService = UserService();
    print('came here');
    _fetchAndAutofillEmail();
  }

  Future<void> _fetchAndAutofillEmail() async {
    print("cam here");
    String? email = await _userService.getCurrentUserEmail();
    print('email to edit');
    print(email);
    
    _emailController.text = email;
    
  }

  void _saveForm() async {
    // Collect form data
    Map<String, dynamic> formData = {
      'email': _emailController.text,
      'fullName': _nameController.text,
      'dob': _dobController.text,
      'location': _locationController.text,
      'bloodGroup': _bloodGroupController.text,
      'height': _heightController.text,
    };

    await _userService.saveFormData(formData);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
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
                  "Personal Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: "Date of Birth",
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: "Location of Birth",
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _bloodGroupController,
                  decoration: const InputDecoration(
                    labelText: "Blood Group",
                    prefixIcon: Icon(Icons.bloodtype),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: "Height",
                    prefixIcon: Icon(Icons.height),
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
