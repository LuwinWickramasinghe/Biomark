import 'package:flutter/material.dart';
import 'package:biomark/responsive.dart';

import '../../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import '../../../constants.dart'; // Assuming constants like kPrimaryColor are in this file

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(),
          desktop: DesktopLoginScreen(),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, // Centered items horizontally
      children: <Widget>[
        const LoginScreenTopImage(),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16), // Reduced margin for mobile
          padding: const EdgeInsets.all(16), // Reduced padding
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8, // Slightly less blur
              ),
            ],
          ),
          child: const LoginForm(),
        ),
      ],
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  const DesktopLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the entire row
      children: [
        const Expanded(
          child: LoginScreenTopImage(),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 450, // Fixed width for desktop form
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const LoginForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
