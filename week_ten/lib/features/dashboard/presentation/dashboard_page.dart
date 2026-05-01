import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_bloc.dart';
import 'package:week_ten_dashboard_app/features/authentication/bloc/auth_state.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:week_ten_dashboard_app/features/dashboard/bloc/dashboard_state.dart';
import 'package:week_ten_dashboard_app/features/dashboard/presentation/activity_list_page.dart';
import 'package:week_ten_dashboard_app/models/user.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildWelcome(context),
              const SizedBox(height: 16),
              Expanded(child: _buildDashboardContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcome(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final user = state is AuthAuthenticated ? state.user : null;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${user?.username ?? 'guest'}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Role: ${user?.role.name.toUpperCase() ?? 'UNKNOWN'}'),
        ],
      );
    });
  }

  Widget _buildDashboardContent(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DashboardLoadSuccess) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: state.metrics.entries.map((entry) {
                    return _DashboardMetricCard(
                      label: entry.key,
                      value: entry.value.toString(),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Navigation',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 10),
                          _buildActionTile(
                            context,
                            title: 'Open activity table',
                            icon: Icons.list,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ActivityListPage()),
                              );
                            },
                          ),
                          const Divider(),
                          _buildActionTile(
                            context,
                            title: 'Profile and logout',
                            icon: Icons.account_circle,
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                          ),
                          const Divider(),
                          if (_isAdmin(context))
                            _buildActionTile(
                              context,
                              title: 'Admin control panel',
                              icon: Icons.admin_panel_settings,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Admin panel is available for admins only.')),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is DashboardLoadFailure) {
          return Center(
              child: Text('Unable to load dashboard: ${state.message}'));
        }
        return const Center(child: Text('No dashboard data available.'));
      },
    );
  }

  bool _isAdmin(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    return state is AuthAuthenticated && state.user.role == UserRole.admin;
  }

  Widget _buildActionTile(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
    );
  }
}

class _DashboardMetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _DashboardMetricCard(
      {Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
