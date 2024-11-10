import 'package:encrypt/encrypt.dart' as encrypt;

String decryptData(String encryptedData) {
  final key = encrypt.Key.fromUtf8('16charSecretKey!'); // The same key used for encryption
  final iv = encrypt.IV.fromLength(16); // The same IV used for encryption

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final decrypted = encrypter.decrypt64(encryptedData, iv: iv); // Decrypt from base64
  return decrypted;
}