import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week Five Demos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/lists'),
              child: const Text('Lists Demo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/animations'),
              child: const Text('Animations Demo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/components'),
              child: const Text('Component Library'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/animated-list'),
              child: const Text('Animated List/Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
