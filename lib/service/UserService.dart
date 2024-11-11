import 'package:biomark/util/encryption_func.dart';
import 'package:biomark/util/firebase_helper.dart';
import 'package:biomark/util/database_helper.dart';
import 'package:biomark/util/hash_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserService {
  static final _dbHelper = DatabaseHelper.instance;
  static final _fbHelper = FirebaseHelper.instance;

  // Method to validate the user
  Future<bool> validateUser(String email, String enteredPassword) async {

    String? password = await _dbHelper.getPasswordByEmail(email);

    if (password == null) {
       print('here3');
      // If password is not cached, fetch user details from Firebase and cache them
      Map<String, dynamic>? user = await _fbHelper.getUserFromFirebase(email);
      if (user == null) return false;
      _dbHelper.cacheUser(user);
      password = user['password'];
    }
    print('here');
    print(password);
    print(hashPassword(enteredPassword));

    // Compare the hashed entered password with the stored hashed password
    return hashPassword(enteredPassword) == password;
  }

// Method to get the current user's email (fetches cached email)
Future<String> getCurrentUserEmail() async {
  // Attempt to get the email from the local cache (email is guaranteed to be available)
  String email = await _dbHelper.getCachedEmail();
  return email;
}

Future<String> getCurrentUserName() async {
  // Attempt to get the email from the local cache (email is guaranteed to be available)
  String name = await _dbHelper.getCachedName();
  return decryptData(name);
}


  // Method to save form data to Firebase
  Future<void> saveFormData(Map<String, dynamic> formData) async {
    await _fbHelper.saveFormToFirebase(formData);
  }

  Future<void> updateEmail(Map<String, dynamic> formData) async {
    await _fbHelper.saveEmailToFirebase(formData);
    await updateLocalEmail(formData['oldemail'], formData['email']);
  }
   Future<void> updatePassword(Map<String, dynamic> formData) async {
    await _fbHelper.saveEmailToFirebase(formData);
    await updateLocalEmail(formData['oldemail'], formData['email']);
  }

  Future<void> updateLocalEmail(String oldEmail, String newEmail) async {
  final db = await _dbHelper.database;
  try {
    // Update the email of the first record matching the old email
    int count = await db.update(
      'users',
      {'email': newEmail}, // New email to update
      where: 'email = ?',
      whereArgs: [oldEmail], // Old email to match
    );

    if (count > 0) {
      print("Email updated successfully");
    } else {
      print("No matching record found for the email");
    }
  } catch (e) {
    print("Error updating email: $e");
  }
}



Future<Map<String, dynamic>?> getUserProfile(String email) async {
  try {
    // Fetch the document for the user by querying the 'email' field
    final querySnapshot = await FirebaseFirestore.instance
        .collection('subscription')
        .where('email', isEqualTo: email) // Query based on the 'email' field
        .limit(1) // Ensure only one document is returned
        .get();
      
    print('sssssssssssssssssssssssssss');

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
}
