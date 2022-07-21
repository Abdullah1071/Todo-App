import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/auth_api.dart';
import 'package:todo_app/providers/google_sign_in_provider.dart';
import 'package:todo_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const route = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _incorrect = false;

  // toggle between hide and show password
  bool _isChecked = false;

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;
      if (remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = email;
      }
    } catch (e) {
      e.toString();
    }
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString('email', _emailController.text);
        prefs.setBool("remember_me", value);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authApi = Provider.of<AuthApi>(context);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/todo_large.png',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
            ),
            height: 50,
            child: CupertinoTextField(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _incorrect
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGrey,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              textInputAction: TextInputAction.next,
              placeholder: 'Phone number or email address',
              placeholderStyle: const TextStyle(
                color: CupertinoColors.white,
              ),
              style: const TextStyle(
                color: CupertinoColors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
            ),
            height: 50,
            child: CupertinoTextField(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _incorrect
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGrey,
                ),
              ),
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              obscureText: true,
              placeholder: 'Password',
              placeholderStyle: const TextStyle(
                color: CupertinoColors.white,
              ),
              style: const TextStyle(
                color: CupertinoColors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                ),
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                    _handleRemeberme(_isChecked);
                  },
                  child: Row(
                    children: [
                      Icon(
                        _isChecked
                            ? CupertinoIcons.checkmark_alt_circle_fill
                            : CupertinoIcons.checkmark_alt_circle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: const Text(
                          'Remember me',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: 15,
                ),
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  child: const Text(
                    'Forgotten Password?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          _loading
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 47,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: CupertinoColors.activeBlue,
                      ),
                      width: 190,
                      child: const CupertinoActivityIndicator(
                        color: CupertinoColors.white,
                        radius: 15,
                      ),
                    )
                  ],
                )
              : Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 100,
                  ),
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });

                      User? user = await authApi.signInWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      setState(() {
                        _loading = false;
                      });
                      if (user != null) {
                        setState(() {
                          _incorrect = false;
                        });
                      } else {
                        setState(() {
                          _incorrect = true;
                        });
                      }
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 15.0,
                  ),
                  child: const Divider(
                    color: CupertinoColors.white,
                    height: 80,
                  ),
                ),
              ),
              const Text(
                'OR',
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15.0,
                    right: 10.0,
                  ),
                  child: const Divider(
                    color: CupertinoColors.white,
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google.png'),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account yet?',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.only(left: 5),
                  minSize: 14,
                  onPressed: () =>
                      Navigator.pushNamed(context, SignUpScreen.route),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: CupertinoButton(
              child: const Text('Maybe later'),
              onPressed: () {
                final provider = Provider.of<AuthApi>(context, listen: false);
                provider.anonymousSignIn();
              },
            ),
          ),
        ],
      ),
    );
  }
}
