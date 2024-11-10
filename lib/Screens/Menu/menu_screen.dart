import 'package:flutter/material.dart';
import '../EditProfile/edit_profile.dart';
import '../AccountRecovery/account_recovery.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSubscribed = false;


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
                    backgroundImage:
                        AssetImage('assets/user_avatar.png'), // Placeholder avatar
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

            // Display personal information only if subscribed
            if (isSubscribed)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Date of Birth'),
                    subtitle: Text('[User Date of Birth]'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Location of Birth'),
                    subtitle: Text('[User Location]'),
                  ),
                  ListTile(
                    leading: Icon(Icons.bloodtype),
                    title: Text('Blood Group'),
                    subtitle: Text('[User Blood Group]'),
                  ),
                  ListTile(
                    leading: Icon(Icons.height),
                    title: Text('Height'),
                    subtitle: Text('[User Height]'),
                  ),
                  // Add more fields as necessary...
                ],
              ),
            
            const SizedBox(height: 20),

            // Action Section
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountRecoveryScreen(),
                          ),
                        );
                      },
                      child: Text("Account Recovery".toUpperCase()),
                    ),
                  const SizedBox(height: 10),
                  if (isSubscribed)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                      child: Text("Edit Profile".toUpperCase()),
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
