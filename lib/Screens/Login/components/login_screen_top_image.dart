import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "LOGIN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.08,
            color: kPrimaryColor, // Scale text size for mobile
          ),
        ),
        SizedBox(height: defaultPadding * 1.5), // Adjust spacing for mobile
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/login.svg",
                width: screenWidth * 0.6, // Adjust image width for mobile
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding * 1.5), // Adjust bottom spacing
      ],
    );
  }
}
