import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biomark/constants.dart';
import 'package:biomark/util/database_helper.dart';
import 'package:biomark/util/firebase_helper.dart';
import '../../service/UserService.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final UserService _userService = UserService();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Email Address Field
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Date of Birth Field
              TextFormField(
                controller: dobController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Location of Birth Field
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: "Location of Birth",
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Blood Group Field
              TextFormField(
                controller: bloodGroupController,
                decoration: const InputDecoration(
                  labelText: "Blood Group",
                  prefixIcon: Icon(Icons.bloodtype),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Height Field
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Height",
                  prefixIcon: Icon(Icons.height),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Save Changes Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _saveProfileData(context);
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfileData(BuildContext context) async {
    try {
      final email = emailController.text;

      // Retrieve the existing user data or create a new profile data map
      final profileData = {
        'fullName': fullNameController.text,
        'email': email,
        'dateOfBirth': dobController.text,
        'locationOfBirth': locationController.text,
        'bloodGroup': bloodGroupController.text,
        'height': heightController.text,
      };

      // Save profile data to Firebase and cache it in SQLite
      await FirebaseFirestore.instance.collection('userProfiles').doc(email).set(profileData);
      await DatabaseHelper.instance.cacheUser(profileData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }
}
