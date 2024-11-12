import 'package:flutter/material.dart';

class AccountRecoveryModel {
  final Map<String, String> recoveryData;

  AccountRecoveryModel({required this.recoveryData});
  
  // Optional: Convenience getters for specific fields, if needed
  String get name => recoveryData["name"] ?? "";
  String get dob => recoveryData["date_of_birth"] ?? "";
  String get email => recoveryData["email"] ?? "";
  List<String> get questionAnswers {
    // Filter keys that aren't name, dob, or email for answers
    return recoveryData.entries
      .where((entry) => entry.key != "name" && entry.key != "date_of_birth" && entry.key != "email")
      .map((entry) => entry.value)
      .toList();
  }
}

class SecurityQuestion {
  final String label;
  final IconData icon;

  SecurityQuestion(this.label, this.icon);

  static List<SecurityQuestion> getAllQuestions() {
    return [
      SecurityQuestion("Mother Maiden Name", Icons.security),
      SecurityQuestion("Best Friend's Name", Icons.people),
      SecurityQuestion("Childhood Pet's Name", Icons.pets),
      SecurityQuestion("Custom Question", Icons.question_mark),
    ];
  }
}
