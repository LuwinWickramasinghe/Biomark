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
  
  // Error messages for each field
  String? nameError;
  String? dobError;
  List<String?> questionErrors = [null, null];
  String? verificationError;

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
    nameError = nameController.text.isEmpty ? 'Name is required' : null;
    dobError = dobController.text.isEmpty ? 'Date of Birth is required' : null;
    questionErrors[0] = questionControllers[0].text.isEmpty ? 'Answer is required' : null;
    questionErrors[1] = questionControllers[1].text.isEmpty ? 'Answer is required' : null;

    isFormValid = nameError == null && dobError == null && questionErrors.every((e) => e == null);
    notifyListeners();
  }

  Future<void> verifyAndProceed() async {
    final Map<String, String> recoveryData = {
      "name": nameController.text,
      "date_of_birth": dobController.text,
      getQuestionLabel(0): questionControllers[0].text,
      getQuestionLabel(1): questionControllers[1].text,
    };

    final user = AccountRecoveryModel(recoveryData: recoveryData);

    isVerified = await _repository.verifyUser(user);
    verificationError = isVerified ? null : 'Verification failed. Please check your answers.';
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
