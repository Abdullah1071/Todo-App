import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/email_signup_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const route = '/AddPhoneEmailScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: const Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.white,
                  size: 32,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Enter email address and password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
              ),
            ),
            const EmailSignUpWidget(),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
