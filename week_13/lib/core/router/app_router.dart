import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week_13/core/constants/app_constants.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/tasks/presentation/pages/home_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.loginRoute,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState is AuthAuthenticated;
      final isOnAuthPage =
          state.matchedLocation == AppConstants.loginRoute ||
          state.matchedLocation == AppConstants.registerRoute;

      if (!isLoggedIn && !isOnAuthPage) return AppConstants.loginRoute;
      if (isLoggedIn && isOnAuthPage) return AppConstants.homeRoute;
      return null;
    },
    routes: [
      GoRoute(
        path: AppConstants.loginRoute,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppConstants.registerRoute,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (_, __) => const AddTaskDialog(),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        builder: (_, __) => const ProfilePage(),
      ),
    ],
  );
}
