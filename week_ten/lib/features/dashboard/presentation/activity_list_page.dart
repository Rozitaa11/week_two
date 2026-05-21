import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_state.dart';

class ActivityListPage extends StatelessWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardLoadSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent activity',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.activities.length,
                      separatorBuilder: (_, __) => const Divider(height: 12),
                      itemBuilder: (context, index) {
                        final row = state.activities[index];
                        return ListTile(
                          title: Text(row['task']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(
                              'Owner: ${row['owner']} • Status: ${row['status']}'),
                          leading: CircleAvatar(
                            child: Text(row['owner']![0]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No activity available.'));
          },
        ),
      ),
    );
  }
}
