// account_recovery_model.dart
import 'package:flutter/material.dart';

class AccountRecoveryModel {
  final String name;
  final String dob;
  final List<String> questionAnswers;

  AccountRecoveryModel({
    required this.name,
    required this.dob,
    required this.questionAnswers,
  });
}

class SecurityQuestion {
  final String label;
  final IconData icon;

  SecurityQuestion(this.label, this.icon);

  static List<SecurityQuestion> getAllQuestions() {
    return [
      SecurityQuestion("Mother's Maiden Name", Icons.security),
      SecurityQuestion("Childhood Best Friend's Name", Icons.people),
      SecurityQuestion("Childhood Pet's Name", Icons.pets),
      SecurityQuestion("Custom Question", Icons.question_mark),
    ];
  }
}
