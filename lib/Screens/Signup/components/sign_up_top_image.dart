import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor, // Updated text color to match primary color
            fontSize: 24, // Adjusted font size for better alignment
            letterSpacing:
                2.0, // Slight letter spacing for better visual effect
          ),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/signup.svg",
                height:
                    250, // Adjusted height to maintain consistent image size
                width: 250, // Ensure the image doesn't stretch unnaturally
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
