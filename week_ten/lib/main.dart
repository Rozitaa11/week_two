import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/app.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_event.dart';
import 'package:week_ten_dashboard_app/repository/auth_repository.dart';
import 'package:week_ten_dashboard_app/repository/dashboard_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<DashboardRepository>(
          create: (_) => DashboardRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              repository: context.read<DashboardRepository>(),
            )..add(const DashboardLoadRequested()),
          ),
        ],
        child: const App(),
      ),
    );
  }
}
