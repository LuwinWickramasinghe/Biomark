import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {

  // Singleton instance of FirebaseHelper
  static final FirebaseHelper instance = FirebaseHelper._privateConstructor();

  // Private constructor to avoid external instantiation
  FirebaseHelper._privateConstructor();

  // Method to get user data from Firebase by email
  Future<Map<String, dynamic>?> getUserFromFirebase(String email) async {
    try {
      // Fetch the document for the user by email from Firestore
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Assuming email is used as the document ID
          .get();

      if (docSnapshot.exists) {
        return docSnapshot.data(); // Return the user data (e.g., password hash)
      } else {
        return null; // User not found
      }
    } catch (e) {
      print("Error fetching user from Firebase: $e");
      return null; // Return null on error
    }
  }
}
