import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';

class SubscribeUnsuccessfulScreen extends StatelessWidget {
  const SubscribeUnsuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biomark Voluteer Program"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              "Subscription Unsuccessful",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding / 2),
            const Text(
              "Subscription to biomark voluteer program is Unsuccessful. Please try again or contact support for assistance.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 2),

            // Retry Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the recovery form to retry
              },
              child: const Text("Retry"),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
