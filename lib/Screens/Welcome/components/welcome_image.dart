import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive adjustments
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "Biomark",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: screenWidth * 0.1, // Responsive font size
            color: Colors.blueAccent,
            letterSpacing: 2.0,
            fontFamily: 'Montserrat',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // Dynamic padding
          child: Text(
            "Leveraging Your Personal Data to Enhance Predictive Modeling and Digital Experiences",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.04, // Responsive font size
              color: Colors.black,
              letterSpacing: 0.5,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: defaultPadding),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
                width: screenWidth * 0.6, // Scale image based on screen width
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
