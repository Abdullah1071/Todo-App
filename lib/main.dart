import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/auth_api.dart';
import 'package:todo_app/providers/google_sign_in_provider.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/signup_screen.dart';
import 'package:todo_app/screens/verify_email_screen.dart';
import 'package:todo_app/widgets/add_todo_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodosProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        ),
        Provider<AuthApi>(
          create: (_) => AuthApi(),
        ),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          barBackgroundColor: CupertinoColors.black,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              color: CupertinoColors.white,
            ),
          ),
        ),
        routes: {
          '/': (p0) => const MainPage(),
          HomeScreen.route: (p0) => const HomeScreen(),
          SignUpScreen.route: (p0) => const SignUpScreen(),
          VerifyEmailScreen.route: (p0) => const VerifyEmailScreen(),
          AddTodoWidget.route: (p0) => const AddTodoWidget(),
        },
        initialRoute: '/',
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoPageScaffold(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
