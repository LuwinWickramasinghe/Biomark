import 'package:flutter/material.dart';



class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biomark Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Section
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/user_avatar.png'), // Placeholder avatar
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, [Full Name]',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal Info Section
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date of Birth'),
              subtitle: Text('[User Date of Birth]'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location of Birth'),
              subtitle: Text('[User Location]'),
            ),
            const ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text('Blood Group'),
              subtitle: Text('[User Blood Group]'),
            ),
            const ListTile(
              leading: Icon(Icons.height),
              title: Text('Height'),
              subtitle: Text('[User Height]'),
            ),
            // Add more fields as necessary...

            const SizedBox(height: 20),

            // Action Section
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Edit Profile
                    },
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Account Recovery
                    },
                    child: const Text('Account Recovery'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
