import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Implicit Animation: AnimatedContainer
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _isExpanded ? 200 : 100,
              height: _isExpanded ? 200 : 100,
              color: _isExpanded ? Colors.blue : Colors.red,
              child: const Center(child: Text('Tap me')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: const Text('Toggle Size & Color'),
            ),
            const SizedBox(height: 40),
            // Hero Animation
            GestureDetector(
              onTap: () => context.go('/hero-detail'),
              child: Hero(
                tag: 'hero-image',
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: const Center(child: Text('Hero')),
                ),
              ),
            ),
            const Text('Tap for Hero transition'),
          ],
        ),
      ),
    );
  }
}

// Hero Detail Screen
class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          child: Container(
            width: 300,
            height: 300,
            color: Colors.green,
            child: const Center(child: Text('Hero Detail')),
          ),
        ),
      ),
    );
  }
}
