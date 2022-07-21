import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/auth_api.dart';
import 'package:todo_app/screens/verify_email_screen.dart';

class EmailSignUpWidget extends StatefulWidget {
  const EmailSignUpWidget({super.key});

  @override
  State<EmailSignUpWidget> createState() => _EmailSignUpWidgetState();
}

class _EmailSignUpWidgetState extends State<EmailSignUpWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Warning Texts
  final String _isNotValidEmailText = "Please enter a valid email address.";
  final String _isNotValidPasswordText =
      "Password must have at least 8 characters including\nOne upper case letter\nOne number\nOne special character";
  final String _isPasswordsNotEqual = 'Passwords do not match';

  // Regex
  final _emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  final _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  // check if any fields are empty
  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  bool _isConfirmPasswordEmpty = true;

// check if the phone number and passwords is valid
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

// check if password and confirm password is equal
  bool _isPasswordsEqual = true;

// toggle between hide and show password
  bool _isHidden = true;

  bool _loading = false;

  void _validateEmail() {
    if (!_emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _isEmailValid = false;
      });
    } else {
      setState(() {
        _isEmailValid = true;
      });
    }
  }

  void _validateEqualPasswords() {
    if (_passwordController.text == _confirmPasswordController.text) {
      setState(() {
        _isPasswordsEqual = true;
      });
    } else {
      setState(() {
        _isPasswordsEqual = false;
      });
    }
  }

  void _validatePassword() {
    if (_passwordRegex.hasMatch(_passwordController.text)) {
      setState(() {
        _isPasswordValid = true;
      });
    } else {
      setState(() {
        _isPasswordValid = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Textfield part
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          height: 50,
          child: CupertinoTextField(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: _isEmailValid
                    ? CupertinoColors.systemGrey
                    : CupertinoColors.systemRed,
              ),
            ),
            suffix: GestureDetector(
              onTap: () {
                setState(() {
                  _emailController.clear();
                });
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 15,
                ),
                child: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: CupertinoColors.systemGrey,
                  size: 18,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            textInputAction: TextInputAction.next,
            placeholder: 'Email address',
            placeholderStyle: const TextStyle(
              color: CupertinoColors.white,
            ),
            style: const TextStyle(
              color: CupertinoColors.white,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _isEmailEmpty = true;
                });
              } else {
                setState(() {
                  _isEmailEmpty = false;
                });
              }
            },
          ),
        ),
        !_isEmailValid
            ? Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                padding: EdgeInsets.zero,
                child: Text(
                  _isNotValidEmailText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: CupertinoColors.systemRed,
                    fontSize: 13,
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          height: 50,
          child: CupertinoTextField(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: _isPasswordValid
                    ? CupertinoColors.systemGrey
                    : CupertinoColors.systemRed,
              ),
            ),
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            obscureText: _isHidden,
            placeholder: 'Password',
            placeholderStyle: const TextStyle(
              color: CupertinoColors.white,
            ),
            style: const TextStyle(
              color: CupertinoColors.white,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _isPasswordEmpty = true;
                });
              } else {
                setState(() {
                  _isPasswordEmpty = false;
                });
              }
            },
          ),
        ),
        !_isPasswordValid
            ? Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  _isNotValidPasswordText,
                  style: const TextStyle(
                    color: CupertinoColors.systemRed,
                    fontSize: 13,
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          height: 50,
          child: CupertinoTextField(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: CupertinoColors.systemGrey),
            ),
            suffix: GestureDetector(
              onTap: () {
                setState(() {
                  _isHidden = !_isHidden;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 15,
                ),
                child: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                  color: CupertinoColors.systemGrey,
                  size: 18,
                ),
              ),
            ),
            controller: _confirmPasswordController,
            textInputAction: TextInputAction.next,
            obscureText: _isHidden,
            placeholder: 'Confirm Password',
            placeholderStyle: const TextStyle(
              color: CupertinoColors.white,
            ),
            style: const TextStyle(
              color: CupertinoColors.white,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _isConfirmPasswordEmpty = true;
                });
              } else {
                setState(() {
                  _isConfirmPasswordEmpty = false;
                });
              }
            },
          ),
        ),
        !_isPasswordsEqual
            ? Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  _isPasswordsNotEqual,
                  style: const TextStyle(
                    color: CupertinoColors.systemRed,
                    fontSize: 13,
                  ),
                ),
              )
            : const SizedBox(),
        _isEmailEmpty == false &&
                _isPasswordEmpty == false &&
                _isConfirmPasswordEmpty == false
            ? _loading
                ? Container(
                    height: 45,
                    margin: const EdgeInsets.only(
                      top: 12,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: CupertinoColors.activeBlue,
                    ),
                    width: double.infinity,
                    child: const CupertinoActivityIndicator(
                      color: CupertinoColors.white,
                      radius: 15,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      disabledColor:
                          CupertinoColors.systemBlue.withOpacity(0.3),
                      onPressed: () async {
                        _validateEmail();
                        _validatePassword();
                        _validateEqualPasswords();
                        if (_isEmailValid &&
                            _isPasswordValid &&
                            _isPasswordsEqual) {
                          setState(() {
                            _loading = true;
                          });
                          final authApi =
                              Provider.of<AuthApi>(context, listen: false);
                          final user =
                              await authApi.registerWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                          setState(() {
                            _loading = false;
                          });
                          if (user == null) {
                            _showAlertDialog();
                            return;
                          }
                          if (!mounted) return;
                          Navigator.pushNamed(context, VerifyEmailScreen.route);
                        } else {
                          return;
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  )
            : Container(
                margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                width: double.infinity,
                child: CupertinoButton.filled(
                  disabledColor: CupertinoColors.systemBlue.withOpacity(0.3),
                  onPressed: null,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  void _showAlertDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text(
          'User with this email already exists',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
