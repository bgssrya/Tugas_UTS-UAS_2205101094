class AppConstants {
  // App Info
  static const String appName = 'Rungokno Tembang';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Aplikasi streaming musik modern';
  
  // API Endpoints
  static const String baseUrl = 'https://api.rungoknotembang.com';
  static const String musicEndpoint = '$baseUrl/music';
  static const String playlistEndpoint = '$baseUrl/playlists';
  static const String userEndpoint = '$baseUrl/users';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // Default Values
  static const List<String> defaultGenres = [
    'Pop',
    'Rock',
    'Jazz',
    'Hip Hop',
    'Electronic',
    'R&B',
    'Indie',
    'Lofi',
    'Klasik',
    'Reggae',
    'Metal',
    'Folk',
    'Blues',
    'Country',
    'Soul',
  ];
  
  // App Colors
  static const List<String> moodColors = [
    '#FF6B8B', // Romantic
    '#8A2BE2', // Energetic
    '#00D4FF', // Chill
    '#4CAF50', // Happy
    '#2196F3', // Sad
    '#FF9800', // Focus
    '#9C27B0', // Party
    '#FF4081', // Workout
  ];
}