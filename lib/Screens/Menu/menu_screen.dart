import 'package:biomark/Screens/EditProfile/edit_email.dart';
import 'package:biomark/Screens/EditProfile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:biomark/components/logout_component.dart';
import '../SubscribeForm/subscribe_form.dart';
import '../../service/UserService.dart';
import 'package:biomark/Screens/SubscriptionConfirm/unsubscribe_sucessful.dart'; // Import the unsubscribe success screen

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

  String? name;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptionStatus();
   // _fetchUserName();
  }

  // Fetch user name asynchronously
  Future<void> _fetchUserName() async {
    String? userName = await _userService.getCurrentUserName();
    setState(() {
      name = userName;
    });
  }

  Future<void> _fetchSubscriptionStatus() async {
    if (isDataLoaded) return;
     String? userName = await _userService.getCurrentUserName();
     setState(() {
      name = userName;
    });
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
        isDataLoaded = true;
      });
    }
  }

  Future<void> _unsubscribeUser() async {
    try {
      await _userService.unsubscribeUser();
      setState(() {
        isSubscribed = false;
      });
      // Navigate to the UnsubscribeSuccessfulScreen upon success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UnsubscribeSuccessfulScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to unsubscribe")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biomark Profile'),
        actions: [
          LogoutComponent(),
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchSubscriptionStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || name == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Center(
                      child: Text(
                        'Welcome, ${name ?? 'Guest'}!', // This will display the user's name or 'Guest' if null
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Personal Information Section
                    if (isSubscribed)
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Subscription Status Section
                    Card(
                      color: isSubscribed ? Colors.green[50] : Colors.red[50],
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.subscriptions,
                              color: isSubscribed ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                isSubscribed ? 'You are subscribed.' : 'Not subscribed.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSubscribed ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Account Settings Section (Edit Email & Password)
                    const Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Center(
                      child: Column(
                        children: [
                          // Show Edit Email and Change Password buttons for both subscribed and unsubscribed users
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditEmail()),
                              );
                            },
                            child: Text("Edit Email".toUpperCase()),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditPassword()),
                              );
                            },
                            child: Text("Change Password".toUpperCase()),
                          ),
                          const SizedBox(height: 10),

                          // Show Unsubscribe button only if subscribed
                          if (isSubscribed) ...[
                            ElevatedButton(
                              onPressed: _unsubscribeUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text("Unsubscribe".toUpperCase()),
                            ),
                          ],

                          // Show Subscribe button only if not subscribed
                          if (!isSubscribed) ...[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SubscribeForm()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 2, 142, 2),
                              ),
                              child: Text("Subscribe".toUpperCase()),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
