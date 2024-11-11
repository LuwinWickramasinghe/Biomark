import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import 'package:biomark/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_question_form.dart';

class SignUpQuestionScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;

  // Constructor to accept the form data (name, email, password)
  const SignUpQuestionScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupQuestionScreen(
              name: name, email: email, password: password),
          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: SignUpQuestionForm(
                          name: name, email: email, password: password),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupQuestionScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;

  const MobileSignupQuestionScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SignUpQuestionForm(
                  name: name, email: email, password: password),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
