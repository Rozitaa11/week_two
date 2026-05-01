import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoadInProgress extends DashboardState {}

class DashboardLoadSuccess extends DashboardState {
  final Map<String, int> metrics;
  final List<Map<String, String>> activities;

  const DashboardLoadSuccess({required this.metrics, required this.activities});

  @override
  List<Object?> get props => [metrics, activities];
}

class DashboardLoadFailure extends DashboardState {
  final String message;

  const DashboardLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
