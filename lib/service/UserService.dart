import 'package:biomark/util/firebase_helper.dart';
import 'package:biomark/util/database_helper.dart';
import 'package:biomark/util/hash_password.dart';



class UserService {
  static final _dbHelper = DatabaseHelper.instance;
  static final _fbHelper = FirebaseHelper.instance;

  // Method to validate the user
  Future<bool> validateUser(String email, String enteredPassword) async {
    // Fetch the stored hashed password from the SQLite database based on the email
    String? password = await _dbHelper.getPasswordByEmail(email);

    if (password == null) {
      // If password is not cached, fetch user details from Firebase and cache them
      Map<String, dynamic>? user = await _fbHelper.getUserFromFirebase(email);
      if (user == null) return false;
      _dbHelper.cacheUser(user);
      password = user['password'];
    }

    // Compare the hashed entered password with the stored hashed password
    return hashPassword(enteredPassword) == password;
  }

// Method to get the current user's email (fetches cached email)
Future<String> getCurrentUserEmail() async {
  // Attempt to get the email from the local cache (email is guaranteed to be available)
  String email = await _dbHelper.getCachedEmail();


  if (email.isEmpty) {
    Map<String, dynamic>? user = await _fbHelper.getUserFromFirebase(email);
    email = user?['email'] ?? '';
    if (email.isNotEmpty) {
      await _dbHelper.cacheEmail(email);
    }
  }
  return email;
}


  // Method to save form data to Firebase
  Future<void> saveFormData(Map<String, dynamic> formData) async {
    await _fbHelper.saveFormToFirebase(formData);
  }
}
