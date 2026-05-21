import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_13/features/auth/data/repositories/auth_repository_impl.dart';

import 'core/router/app_router.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/tasks/data/datasources/task_firestore_datasource.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/usecases/add_task.dart';

import 'features/tasks/presentation/bloc/task_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!(kIsWeb || defaultTargetPlatform == TargetPlatform.linux)) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authDataSource = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authDataSource);

    final taskDataSource = TaskFirestoreDataSource();
    final taskRepository = TaskRepositoryImpl(taskDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            loginUser: LoginUser(authRepository),
            registerUser: RegisterUser(authRepository),
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (_) => TaskBloc(
            addTask: AddTask(taskRepository),
            updateTask: UpdateTask(taskRepository),
            deleteTask: DeleteTask(taskRepository),
            getTasks: GetTasks(taskRepository),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Firebase Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
