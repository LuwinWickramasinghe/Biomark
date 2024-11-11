import 'package:encrypt/encrypt.dart' as encrypt;

String encryptData(String data) {
  // Ensure the key is exactly 16 bytes (AES-128 requires 16-byte key)
  final key = encrypt.Key.fromUtf8('1234567890123456'); // 16-byte key
  final iv = encrypt.IV.fromUtf8('1234567890123456');  // 16-byte IV
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  // Encrypt the data and return the encrypted base64 string
  final encrypted = encrypter.encrypt(data, iv: iv);
  return encrypted.base64;
}

String decryptData(String encryptedData) {
  // Ensure the key is exactly 16 bytes (same as for encryption)
  final key = encrypt.Key.fromUtf8('1234567890123456'); // 16-byte key
  final iv = encrypt.IV.fromUtf8('1234567890123456');  // 16-byte IV (same as used for encryption)
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  try {
    // Decrypt from base64 and return the decrypted string
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;
  } catch (e) {
    print("Error during decryption: $e");
    return '';  // Return an empty string if decryption fails
  }
}