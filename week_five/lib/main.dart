import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart';
import 'lists_screen.dart';
import 'animations_screen.dart';
import 'component_library_screen.dart';
import 'animated_list_detail_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/lists',
          builder: (context, state) => const ListsScreen(),
        ),
        GoRoute(
          path: '/animations',
          builder: (context, state) => const AnimationsScreen(),
        ),
        GoRoute(
          path: '/hero-detail',
          builder: (context, state) => const HeroDetailScreen(),
        ),
        GoRoute(
          path: '/components',
          builder: (context, state) => const ComponentLibraryScreen(),
        ),
        GoRoute(
          path: '/animated-list',
          builder: (context, state) => const AnimatedListDetailScreen(),
        ),
        GoRoute(
          path: '/item-detail/:index',
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            return ItemDetailScreen(index: index);
          },
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }
}
