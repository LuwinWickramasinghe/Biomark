import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';
import '../../../constants.dart';
import '../../../components/already_have_an_account_acheck.dart';

class SignUpQuestionForm extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const SignUpQuestionForm({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SignUpQuestionFormState createState() => _SignUpQuestionFormState();
}

class _SignUpQuestionFormState extends State<SignUpQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _motherMaidenNameController = TextEditingController();
  final _bestFriendsNameController = TextEditingController();
  final _childhoodPetsNameController = TextEditingController();
  final _customQuestionController = TextEditingController();

  // Encrypt method for sensitive data (Name & Email)
  String encryptData(String data) {
     final key = encrypt.Key.fromUtf8('1234567890123456'); // 16-byte key
  final iv = encrypt.IV.fromUtf8('1234567890123456');  // Initialization vector (IV) should also be 16 bytes
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  // Hash method for password and security questions
  String hashData(String password) {
  // Convert the password into bytes
  var bytes = utf8.encode(password);

  // Perform SHA256 hashing
  var digest = sha256.convert(bytes);

  return digest.toString(); // Return the hashed password
}

  // Submit the form and save data to Firebase
  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final hashedPassword = hashData(widget.password);
      final encryptedName = encryptData(widget.name);
      final email = widget.email;

      // Hash the answers to the security questions
      final hashedMotherMaidenName = hashData(_motherMaidenNameController.text);
      final hashedBestFriendsName = hashData(_bestFriendsNameController.text);
      final hashedChildhoodPetsName = hashData(_childhoodPetsNameController.text);
      final hashedCustomQuestion = hashData(_customQuestionController.text);

      try {
        // Save the data to Firebase
        await FirebaseFirestore.instance.collection('users').add({
          'name': encryptedName,
          'email': email,
          'password': hashedPassword,
          'motherMaidenName': hashedMotherMaidenName,
          'bestFriendsName': hashedBestFriendsName,
          'childhoodPetsName': hashedChildhoodPetsName,
          'customQuestion': hashedCustomQuestion,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form Submitted Successfully')),
        );

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting form')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Column(
              children: [
                // Security Question 1: Mother's Maiden Name
                TextFormField(
                  controller: _motherMaidenNameController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Mother's Maiden Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your mother's maiden name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding),

                // Security Question 2: Childhood Best Friend's Name
                TextFormField(
                  controller: _bestFriendsNameController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Childhood Best Friend's Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.people),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your childhood best friend's name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding),

                // Security Question 3: Childhood Pet's Name
                TextFormField(
                  controller: _childhoodPetsNameController,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Childhood Pet's Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.pets),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your childhood pet's name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding),

                // Custom Question
                TextFormField(
                  controller: _customQuestionController,
                  textInputAction: TextInputAction.done,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Your Custom Question",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.question_answer),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your custom question";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: submitForm,
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
