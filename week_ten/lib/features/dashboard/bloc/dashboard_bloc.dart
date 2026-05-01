import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_event.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_state.dart';
import 'package:week_ten_dashboard_app/repository/dashboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
      DashboardLoadRequested event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadInProgress());
    try {
      final metrics = await repository.fetchMetrics();
      final activities = await repository.fetchActivityRows();
      emit(DashboardLoadSuccess(metrics: metrics, activities: activities));
    } catch (error) {
      emit(DashboardLoadFailure(error.toString()));
    }
  }
}
