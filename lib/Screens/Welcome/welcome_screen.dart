import 'package:flutter/material.dart';

import '../../components/background.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: MobileWelcomeScreen(),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0), // Add padding for better alignment
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align children to the center
        children: <Widget>[
          // Added spacing and color to improve the UI
          Container(
            margin: const EdgeInsets.only(bottom: 30.0),
            child: const WelcomeImage(),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 15.0), // Padding around the button
            decoration: BoxDecoration(
              color: const Color.fromARGB(86, 68, 137,
                  255), // Background color for the button container
              borderRadius: BorderRadius.circular(
                  8.0), // Rounded corners for the button container
            ),
            child: const Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the buttons horizontally
              children: [
                Expanded(
                  flex: 8,
                  child: LoginAndSignupBtn(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
