import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';

class RecoveryUnsuccessfulScreen extends StatelessWidget {
  const RecoveryUnsuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Recovery",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color.fromARGB(59, 66, 164,
                245), // Set card background color to match previous screens
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 100,
                  ),
                  const SizedBox(height: defaultPadding),
                  const Text(
                    "Recovery Failed",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "The information you provided does not match our records. Please try again or contact support for assistance.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: defaultPadding * 2),

                  // Retry Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Go back to the recovery form to retry
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kPrimaryColor, // Use primaryColor from constants
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: const Text(
                      "Retry",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  // Contact Support Button
                  TextButton(
                    onPressed: () {
                      // Implement contact support logic here
                    },
                    child: const Text(
                      "Contact Support",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
