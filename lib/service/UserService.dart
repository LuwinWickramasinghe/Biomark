import 'package:biomark/util/firebase_helper.dart';
import '../../../util/database_helper.dart';
import '../../../util/hash_password.dart';

class UserService {

  static final _dbHelper = DatabaseHelper.instance;
  static final _fbHelper = FirebaseHelper.instance;

  // Method to validate the user
  Future<bool> validateUser(String email, String enteredPassword) async {
    // Fetch the stored hashed password from the SQLite database based on the email
    print("here");
     print(email);
    String? password = await _dbHelper.getPasswordByEmail(email);

    if(password==null){
     
      Map<String, dynamic>? user = await _fbHelper.getUserFromFirebase(email);
      print(user);
      if(user==null) return false;
      _dbHelper.cacheUser(user);
      password = user['password'];
    }

    // Compare the hashed entered password with the stored hashed password
    return hashPassword(enteredPassword) == password;
  }

}
