// lib/screens/menu_screen.dart

import 'package:biomark/Screens/EditProfile/edit_email.dart';
import 'package:biomark/Screens/EditProfile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:biomark/components/logout_component.dart'; // Import the LogoutComponent
import '../SubscribeForm/subscribe_form.dart';
import '../../service/UserService.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final UserService _userService = UserService();

  bool isSubscribed = false;
  String? fullName;
  String? dob;
  String? location;
  String? bloodGroup;
  String? height;

  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptionStatus();
  }

  Future<void> _fetchSubscriptionStatus() async {
    if (isDataLoaded) return;

    String? email = await _userService.getCurrentUserEmail();

    final userProfile = await _userService.getUserProfile(email);

    if (userProfile != null && userProfile.containsKey('isSubscribed')) {
      setState(() {
        isSubscribed = userProfile['isSubscribed'] as bool;

        fullName = userProfile['fullName'] as String?;
        dob = userProfile['dob'] as String?;
        location = userProfile['location'] as String?;
        bloodGroup = userProfile['bloodGroup'] as String?;
        height = userProfile['height'] as String?;
        isDataLoaded = true;
      });
    } else {
      setState(() {
        isSubscribed = false;
        isDataLoaded = true; // Default if not found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biomark Profile'),
        actions: [
          LogoutComponent(), // Use the LogoutComponent here
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchSubscriptionStatus(), // Execute the function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle any errors during fetching
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            // Build the UI with the fetched data
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome! ${fullName ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Personal Info Section
                  if (isSubscribed != null && isSubscribed!) ...[
                    const Text(
                      'Personal Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Date of Birth'),
                      subtitle: Text(dob ?? '[User Date of Birth]'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Location of Birth'),
                      subtitle: Text(location ?? '[User Location]'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bloodtype),
                      title: const Text('Blood Group'),
                      subtitle: Text(bloodGroup ?? '[User Blood Group]'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.height),
                      title: const Text('Height'),
                      subtitle: Text(height ?? '[User Height]'),
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
                          : isSubscribed!
                              ? 'Subscribed'
                              : 'Not Subscribed',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action Section
                  Center(
                    child: Column(
                      children: [
                        if (isSubscribed != null && isSubscribed!) ...[
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
                        if (isSubscribed == null || !isSubscribed!) ...[
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
