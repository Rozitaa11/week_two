import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_state.dart';
import 'package:week_ten_dashboard_app/features/authentication/presentation/login_page.dart';
import 'package:week_ten_dashboard_app/features/dashboard/presentation/dashboard_page.dart';
import 'package:week_ten_dashboard_app/features/profile/presentation/profile_page.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week Ten Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const EntryPage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const DashboardPage();
        }
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const LoginPage();
      },
    );
  }
}
