import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomark/viewmodels/account_recovery_view_model.dart';
import '../RecoveryConfirmation/recovery_confirmation_screen.dart';

class AccountRecoveryScreen extends StatelessWidget {
  const AccountRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AccountRecoveryViewModel>(context);
    final themeColor = const Color(0xFF2AA2F2); // Main theme color

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        title: const Text(
          "Account Recovery",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF3F4F6), // Soft background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recover Your Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Card for fields with a modern design
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 6,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      TextFormField(
                        controller: viewModel.nameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.person, color: Colors.grey),
                          errorText: viewModel.nameError,
                        ),
                        onChanged: (_) => viewModel.updateFormValidity(),
                      ),
                      const SizedBox(height: 16),

                      // Date of Birth Field with Date Picker
                      TextFormField(
                        controller: viewModel.dobController,
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                          errorText: viewModel.dobError,
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ) ??
                              DateTime.now();
                          viewModel.dobController.text =
                              "${selectedDate.toLocal()}".split(' ')[0];
                          viewModel.updateFormValidity();
                        },
                      ),
                      const SizedBox(height: 16),

                      // First Security Question
                      TextFormField(
                        controller: viewModel.questionControllers[0],
                        decoration: InputDecoration(
                          labelText: viewModel.getQuestionLabel(0),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(viewModel.getQuestionIcon(0), color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.refresh, color: Colors.grey),
                            onPressed: () => viewModel.replaceQuestion(0),
                          ),
                          errorText: viewModel.questionErrors[0],
                        ),
                        onChanged: (_) => viewModel.updateFormValidity(),
                      ),
                      const SizedBox(height: 16),

                      // Second Security Question
                      TextFormField(
                        controller: viewModel.questionControllers[1],
                        decoration: InputDecoration(
                          labelText: viewModel.getQuestionLabel(1),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(viewModel.getQuestionIcon(1), color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.refresh, color: Colors.grey),
                            onPressed: () => viewModel.replaceQuestion(1),
                          ),
                          errorText: viewModel.questionErrors[1],
                        ),
                        onChanged: (_) => viewModel.updateFormValidity(),
                      ),
                      const SizedBox(height: 16),

                      // Display error message for the overall verification status
                      if (viewModel.verificationError != null)
                        Center(
                          child: Text(
                            viewModel.verificationError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Next Button
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    onPressed: viewModel.isFormValid
                        ? () async {
                            await viewModel.verifyAndProceed();
                            if (viewModel.isVerified) {
                              // Pass email to PasswordResetScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PasswordResetScreen(
                                    userEmail: viewModel.userEmail ?? '',
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
                    child: const Text(
                      "NEXT",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
