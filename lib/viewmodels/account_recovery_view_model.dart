import 'package:flutter/material.dart';
import 'dart:math';
import 'package:biomark/models/account_recovery_model.dart';
import 'package:biomark/repository/repository.dart';

class AccountRecoveryViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final List<TextEditingController> questionControllers =
      List.generate(2, (_) => TextEditingController());

  final List<SecurityQuestion> _allQuestions = SecurityQuestion.getAllQuestions();
  int _firstQuestionIndex = 0;
  int _secondQuestionIndex = 1;

  final Repository _repository = Repository();

  bool isFormValid = false;
  bool isVerified = false;

  void replaceQuestion(int questionIndex) {
    List<SecurityQuestion> remainingQuestions = _allQuestions
        .where((q) => q != _allQuestions[_firstQuestionIndex] && q != _allQuestions[_secondQuestionIndex])
        .toList();

    if (remainingQuestions.isNotEmpty) {
      final random = Random();
      final newQuestion = remainingQuestions[random.nextInt(remainingQuestions.length)];

      if (questionIndex == 0) {
        _firstQuestionIndex = _allQuestions.indexOf(newQuestion);
        questionControllers[0].clear();
      } else {
        _secondQuestionIndex = _allQuestions.indexOf(newQuestion);
        questionControllers[1].clear();
      }
      notifyListeners();
    }
  }

  String getQuestionLabel(int index) {
    return index == 0 ? _allQuestions[_firstQuestionIndex].label : _allQuestions[_secondQuestionIndex].label;
  }

  IconData getQuestionIcon(int index) {
    return index == 0 ? _allQuestions[_firstQuestionIndex].icon : _allQuestions[_secondQuestionIndex].icon;
  }

  void updateFormValidity() {
    isFormValid = nameController.text.isNotEmpty &&
                  dobController.text.isNotEmpty &&
                  questionControllers.every((c) => c.text.isNotEmpty);
    notifyListeners();
  }

  Future<void> verifyAndProceed() async {
    // Create a map for all key-value pairs without email
    final Map<String, String> recoveryData = {
      "name": nameController.text,
      "date_of_birth": dobController.text,
      getQuestionLabel(0): questionControllers[0].text,
      getQuestionLabel(1): questionControllers[1].text,
    };

    // Pass the map to AccountRecoveryModel
    final user = AccountRecoveryModel(recoveryData: recoveryData);

    isVerified = await _repository.verifyUser(user);
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    for (var controller in questionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
