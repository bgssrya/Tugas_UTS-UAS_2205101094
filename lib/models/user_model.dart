import 'music_model.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String subscriptionType;
  final List<String> favoriteGenres;
  final List<Playlist> playlists;
  final int totalListeningMinutes;
  final DateTime joinDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.subscriptionType = 'Free',
    this.favoriteGenres = const [],
    this.playlists = const [],
    this.totalListeningMinutes = 0,
    required this.joinDate,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? subscriptionType,
    List<String>? favoriteGenres,
    List<Playlist>? playlists,
    int? totalListeningMinutes,
    DateTime? joinDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      playlists: playlists ?? this.playlists,
      totalListeningMinutes:
          totalListeningMinutes ?? this.totalListeningMinutes,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
