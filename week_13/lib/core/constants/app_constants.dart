class AppConstants {
  AppConstants._();

  // Firestore collections
  static const String usersCollection = 'users';
  static const String tasksCollection = 'tasks';

  // Storage paths
  static const String profileImagesPath = 'profile_images';

  // Route names
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxTaskTitleLength = 100;
}
