import 'package:flutter/material.dart';
import 'package:week_three/pages/signup.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 131, 93, 137),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 54,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'Welcome! We’re glad you’re here—this is a place to learn...',
              ),

              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
