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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(104, 66, 164, 245),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Full Name Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Email Address Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Date of Birth Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Date of Birth",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Location of Birth Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Location of Birth",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Blood Group Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Blood Group",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      prefixIcon: Icon(Icons.bloodtype),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Height Field
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height",
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
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
        ),
      ),
    );
  }
}
