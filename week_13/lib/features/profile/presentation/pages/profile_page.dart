import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week_13/core/constants/app_constants.dart';

import '../../../../core/services/storage_service.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/profile_image_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storageService = StorageService();
  final _authDataSource = AuthRemoteDataSource();
  bool _uploadingImage = false;

  Future<void> _onImageSelected(File imageFile) async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _uploadingImage = true);
    try {
      final url = await _storageService.uploadProfileImage(
        userId: authState.user.uid,
        imageFile: imageFile,
        onProgress: (p) {
          // Could surface progress here
        },
      );

      await _authDataSource.updatePhotoUrl(
        uid: authState.user.uid,
        photoUrl: url,
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Profile photo updated!')));
        // Refresh auth state
        context.read<AuthBloc>().add(AppStarted());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: BackButton(
          onPressed: () => context.go(AppConstants.homeRoute),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! AuthAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = state.user;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                ProfileImageWidget(
                  photoUrl: user.photoUrl,
                  isLoading: _uploadingImage,
                  onImageSelected: _onImageSelected,
                ),
                const SizedBox(height: 24),
                Text(
                  user.displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Member since ${user.createdAt.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  onPressed: () =>
                      context.read<AuthBloc>().add(LogoutRequested()),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
