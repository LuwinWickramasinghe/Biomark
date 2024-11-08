import 'package:biomark/Screens/SignupQuestions/components/signup_question_form.dart';
import 'package:flutter/material.dart';
import 'package:biomark/constants.dart';
import 'package:biomark/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';


class SignUpQuestionScreen extends StatelessWidget {
  const SignUpQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupQuestionScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: SignUpQuestionForm(),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
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
  const MobileSignupQuestionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpQuestionForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
