import 'package:flutter/material.dart';
import 'package:week_three/pages/welcome.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Welcome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Only Scaffold
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 246, 246, 246),
              Color.fromARGB(255, 126, 25, 141),
            ],
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Signup',
                style: TextStyle(
                  fontSize: 54,
                  color: Colors.white,
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',

                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Sign In'),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Forgot Password?'),
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
