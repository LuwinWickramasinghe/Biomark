import 'package:biomark/Screens/EditProfile/edit_email.dart';
import 'package:biomark/Screens/EditProfile/edit_password.dart';
import 'package:flutter/material.dart';
import '../SubscribeForm/subscribe_form.dart';
import '../AccountRecovery/account_recovery.dart';
import '../../service/UserService.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final UserService _userService = UserService();
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptionStatus();
  }

  Future<void> _fetchSubscriptionStatus() async {
    final userProfile = await _userService.getUserProfile();
    if (userProfile != null && userProfile.containsKey('isSubscribed')) {
      setState(() {
        //isSubscribed = userProfile['isSubscribed'] as bool;
        isSubscribed = true;
      });
    } else {
      setState(() {
        isSubscribed = true; // Default if not found
      });
    }
  }

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
            if(isSubscribed)...[
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
              const SizedBox(height: 10),
            ],

            // Subscription Status Section
            ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text('Subscription Status'),
              subtitle: Text(
                isSubscribed == null
                    ? 'Loading...'
                    : isSubscribed! ? 'Subscribed' : 'Not Subscribed',
              ),
            ),

            const SizedBox(height: 20),

            // Action Section
            
              Center(
                
                child: Column(
                  children: [
                    if(isSubscribed)...[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditEmail(),
                              ),
                            );
                          },
                          child: Text("Edit Email".toUpperCase()),
                        ),

                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPassword(),
                              ),
                            );
                          },
                          child: Text("Change Password".toUpperCase()),
                        ),
                    ],
                    if(!isSubscribed)
                      ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubscribeForm(),
                                ),
                              );
                            },
                            child: Text("Subscribe".toUpperCase()),
                          ),
                          const SizedBox(height: 10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
