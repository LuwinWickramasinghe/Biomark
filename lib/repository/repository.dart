import 'package:biomark/models/account_recovery_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> verifyUser(AccountRecoveryModel user) async {
    // Check in SQLite for existing hashed values
    // Assuming a function exists to verify locally (this part is not provided in the code)

    // If not found locally, check Firebase and store in SQLite
    final isVerified = await _verifyInFirebase(user);
    return isVerified;
  }

  Future<bool> _verifyInFirebase(AccountRecoveryModel user) async {
    try {
      // Query Firestore for the user with matching details
      final querySnapshot = await _firestore
          .collection('users')
          .where('name', isEqualTo: user.name)
          .where('dob', isEqualTo: user.dob) // Adjust based on your model
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // The user details match and are found in Firestore
        return true;
      } else {
        // No matching user found
        return false;
      }
    } catch (e) {
      // Catch any errors during Firestore verification
      print("Error during Firestore verification: $e");
      return false;
    }
  }
}
