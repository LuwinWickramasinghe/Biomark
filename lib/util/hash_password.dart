import 'package:crypto/crypto.dart';
import 'dart:convert';

// Function to hash the password
String hashPassword(String password) {
  // Convert the password into bytes
  var bytes = utf8.encode(password);

  // Perform SHA256 hashing
  var digest = sha256.convert(bytes);

  return digest.toString(); // Return the hashed password
}
