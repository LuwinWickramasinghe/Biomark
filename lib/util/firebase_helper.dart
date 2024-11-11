import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {

  // Singleton instance of FirebaseHelper
  static final FirebaseHelper instance = FirebaseHelper._privateConstructor();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Private constructor to avoid external instantiation
  FirebaseHelper._privateConstructor();

  // Method to get user data from Firebase by email
  Future<Map<String, dynamic>?> getUserFromFirebase(String email) async {
  try {
    // Fetch the document for the user by querying the 'email' field
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email) // Query based on the 'email' field
        .limit(1) // Ensure only one document is returned
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data(); // Return the first matched user document
    } else {
      return null; // User not found
    }
  } catch (e) {
    print("Error fetching user from Firebase: $e");
    return null; // Return null on error
  }
}
// Method to save form data to Firebase Firestore
  Future<void> saveFormToFirebase(Map<String, dynamic> formData) async {
    try {
      // Assuming each form submission is a new document in a 'form_submissions' collection
      await _firestore.collection('subscription').add(formData);
    } catch (e) {
      print("Error saving form data to Firebase: $e");
    }
  }

Future<void> saveEmailToFirebase(Map<String, dynamic> formData) async {
  String oldEmail = formData['oldemail'];
  String newEmail = formData['email'];

  // Helper function to update email in a specific collection
  Future<void> _updateEmail(String collectionName) async {
    try {
      // Query to find the document with the old email
      final querySnapshot = await _firestore
          .collection(collectionName)
          .where('email', isEqualTo: oldEmail)
          .get();

      // Check if a document with the old email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        final documentId = querySnapshot.docs.first.id;

        // Update the email field in the document
        await _firestore.collection(collectionName).doc(documentId).update({
          'email': newEmail,
        });

        print("Updated email in $collectionName collection.");
      } else {
        print("No document found with the old email in $collectionName collection.");
      }
    } catch (e) {
      print("Error updating email in $collectionName collection: $e");
    }
  }

  // Update email in both 'subscription' and 'users' collections
  await _updateEmail('subscription');
  await _updateEmail('users');
}


  

}
