import 'dart:async';

class DashboardRepository {
  Future<Map<String, int>> fetchMetrics() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return {
      'Active projects': 18,
      'Open tickets': 24,
      'Completed sprints': 12,
      'Team capacity': 76,
    };
  }

  Future<List<Map<String, String>>> fetchActivityRows() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return [
      {'task': 'Reviewed product roadmap', 'status': 'Done', 'owner': 'Emma'},
      {'task': 'Deployed version 3.2', 'status': 'In Review', 'owner': 'Jay'},
      {'task': 'Onboarded new analyst', 'status': 'Pending', 'owner': 'Priya'},
      {'task': 'Generated KPI report', 'status': 'Done', 'owner': 'Mina'},
    ];
  }
}
