import 'package:biomark/Screens/Menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';

class UnsubscribeSuccessfulScreen extends StatelessWidget {
  const UnsubscribeSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biomark Volunteer Program"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.red,
              size: 100,
            ),
            const SizedBox(height: defaultPadding),
            const Text(
              "Successfully Unsubscribed",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding / 2),
            const Text(
              "You have successfully unsubscribed from the Biomark volunteer program.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 2),

            // Back to Home Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                  (route) => false,
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
