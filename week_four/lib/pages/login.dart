import 'package:flutter/material.dart';
import 'package:week_four/pages/forgot_password.dart';
import 'package:week_four/pages/signup.dart';
import 'package:week_four/theme/theme_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Signup()),
    );
  }

  void forgotPassword() {
    // Navigate to the Forgot Password page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: toggleAppThemeMode,
        child: const Icon(Icons.brightness_6),
        tooltip: 'Toggle Light/Dark',
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 54,
                  color: Theme.of(context).colorScheme.primary,

                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // spacing
              const Text('Email:'),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Don\'t have account',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,

                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: forgotPassword,

                    child: const Text('Forgot Password'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
