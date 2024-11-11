import 'package:flutter/material.dart';
// import '../SubscribeForm/subscribe_form.dart';
// import 'package:biomark/Screens/EditProfile/edit_email.dart';
// import 'package:biomark/Screens/EditProfile/edit_password.dart';
import '../EditProfile/edit_profile.dart';
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
        title: const Text(
          'Biomark Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
                    backgroundImage: AssetImage(
                        'assets/user_avatar.png'), // Placeholder avatar
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, [Full Name]',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal Info Section
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                'Date of Birth',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '[User Date of Birth]',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                'Location of Birth',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '[User Location]',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text(
                'Blood Group',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '[User Blood Group]',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.height),
              title: Text(
                'Height',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '[User Height]',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),

            const SizedBox(height: 20),

            // Action Section

              Center(

                child: Column(
                  children: [
                    if(isSubscribed)...[ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEmail(),
                        ),
                      );
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
                    child: Text(
                      "Edit Email".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.blue[100],
                      elevation: 12,
                      shadowColor: Colors.black.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    child: Text(
                      "Subscribe".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),const SizedBox(height: 10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
