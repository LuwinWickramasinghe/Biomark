import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              TextFormField(
                initialValue: "[User Full Name]",
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Email Address Field
              TextFormField(
                initialValue: "[User Email Address]",
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Date of Birth Field
              TextFormField(
                initialValue: "[User Date of Birth]",
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Location of Birth Field
              TextFormField(
                initialValue: "[User Location of Birth]",
                decoration: const InputDecoration(
                  labelText: "Location of Birth",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Blood Group Field
              TextFormField(
                initialValue: "[User Blood Group]",
                decoration: const InputDecoration(
                  labelText: "Blood Group",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.bloodtype),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Height Field
              TextFormField(
                initialValue: "[User Height]",
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Height",
                  labelStyle: TextStyle(fontFamily: 'Montserrat'),
                  prefixIcon: Icon(Icons.height),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Save Changes Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save changes action
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blueAccent,
                    elevation: 12,
                    shadowColor: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
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
    );
  }
}
