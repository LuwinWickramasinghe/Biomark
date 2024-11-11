import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomark/viewmodels/account_recovery_view_model.dart';
import '../RecoveryConfirmation/recovery_confirmation_screen.dart';

class AccountRecoveryScreen extends StatelessWidget {
  const AccountRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AccountRecoveryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Recovery"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recover Your Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              TextFormField(
                controller: viewModel.nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (_) => viewModel.updateFormValidity(),
              ),
              const SizedBox(height: 20),

              // Date of Birth Field with Date Picker
              TextFormField(
                controller: viewModel.dobController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    viewModel.dobController.text = "${selectedDate.toLocal()}".split(' ')[0];
                    viewModel.updateFormValidity();
                  }
                },
                onChanged: (_) => viewModel.updateFormValidity(),
              ),
              const SizedBox(height: 20),

              // First Security Question
              TextFormField(
                controller: viewModel.questionControllers[0],
                decoration: InputDecoration(
                  labelText: viewModel.getQuestionLabel(0),
                  prefixIcon: Icon(viewModel.getQuestionIcon(0)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => viewModel.replaceQuestion(0),
                  ),
                ),
                onChanged: (_) => viewModel.updateFormValidity(),
              ),
              const SizedBox(height: 20),

              // Second Security Question
              TextFormField(
                controller: viewModel.questionControllers[1],
                decoration: InputDecoration(
                  labelText: viewModel.getQuestionLabel(1),
                  prefixIcon: Icon(viewModel.getQuestionIcon(1)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => viewModel.replaceQuestion(1),
                  ),
                ),
                onChanged: (_) => viewModel.updateFormValidity(),
              ),
              const SizedBox(height: 20),

              // Next Button
              Center(
                child: ElevatedButton(
                  onPressed: viewModel.isFormValid
                      ? () async {
                          await viewModel.verifyAndProceed();
                          if (viewModel.isVerified) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PasswordResetScreen(),
                              ),
                            );
                          }
                        }
                      : null,
                  child: const Text("NEXT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
