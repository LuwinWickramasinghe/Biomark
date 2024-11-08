import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';

class AccountRecoveryScreen extends StatelessWidget {
  const AccountRecoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Recovery"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recover Your Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Date of Birth Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  // Optional: Open date picker
                },
              ),
              const SizedBox(height: defaultPadding),

              // Security Question 1: Mother's Maiden Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Mother's Maiden Name",
                  prefixIcon: Icon(Icons.security),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Security Question 2: Childhood Best Friend's Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Childhood Best Friend's Name",
                  prefixIcon: Icon(Icons.people),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Security Question 3: Childhood Pet's Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Childhood Pet's Name",
                  prefixIcon: Icon(Icons.pets),
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Recover Account Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle account recovery action
                  },
                  child: const Text("Recover Account"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
