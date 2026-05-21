import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_event.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_state.dart';
import 'package:week_ten_dashboard_app/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthRequested>(_onAuthRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthRequested(
      AuthRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(
        username: event.username,
        password: event.password,
        selectedRole: event.role,
      );
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(error.toString().replaceFirst('Exception: ', '')));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}
