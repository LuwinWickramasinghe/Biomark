import 'package:flutter/material.dart';

import '../../Login/login_screen.dart';
import '../../RecoveryConfirmation/recovery_confirmation_screen.dart';
import '../../RecoveryConfirmation/recovery_successful.dart';
import '../../RecoveryConfirmation/recovery_unsuccessful.dart';
import '../../Signup/signup_screen.dart';
import '../../Menu/menu_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          child: Text(
            "Login".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const RecoveryUnsuccessfulScreen();
                },
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          child: Text(
            "Go to Menu".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ],
    );
  }
}
