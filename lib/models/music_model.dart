class Music {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String imageUrl;
  final String audioUrl;
  final Duration duration;
  final bool isFavorite;
  final int playCount;
  final String genre;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
    this.isFavorite = false,
    this.playCount = 0,
    this.genre = 'Pop',
  });

  Music copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? imageUrl,
    String? audioUrl,
    Duration? duration,
    bool? isFavorite,
    int? playCount,
    String? genre,
  }) {
    return Music(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      playCount: playCount ?? this.playCount,
      genre: genre ?? this.genre,
    );
  }
}

// ================= PLAYLIST =================

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final List<Music> songs;
  final String creator;
  final int songCount;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.songs,
    required this.creator,
    required this.songCount,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    List<Music>? songs,
    String? creator,
    int? songCount,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      songs: songs ?? this.songs,
      creator: creator ?? this.creator,
      songCount: songCount ?? this.songCount,
    );
  }
}
