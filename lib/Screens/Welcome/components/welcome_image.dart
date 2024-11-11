import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Biomark",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 60,
            color: Colors.blueAccent, // Adjusted color to match the theme
            letterSpacing: 2.0,
            fontFamily:
                'Montserrat', // Use the Montserrat font family defined in pubspec.yaml
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.0), // Horizontal padding for the description text
          child: Text(
            "Leveraging Your Personal Data to Enhance Predictive Modeling and Digital Experiences",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
              letterSpacing: 0.5,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center, // Center-aligning the text
          ),
        ),
        const SizedBox(height: defaultPadding),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg", // No size change
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
