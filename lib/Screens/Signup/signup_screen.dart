import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import 'package:biomark/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(),
          desktop: DesktopSignupScreen(),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center the children horizontally
      children: <Widget>[
        const SignUpScreenTopImage(),
        const SizedBox(height: 20),
        Container(
          margin:
              const EdgeInsets.symmetric(horizontal: 20), // Padding from edges
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kPrimaryLightColor, // Background color for form
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: const SignUpForm(),
        ),
      ],
    );
  }
}

class DesktopSignupScreen extends StatelessWidget {
  const DesktopSignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the row content
      children: [
        const Expanded(
          child: SignUpScreenTopImage(),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center, // Center the form on desktop
            child: SizedBox(
              width: 450, // Fix the width of the form
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      kPrimaryLightColor, // Light background color for the form
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const SignUpForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
