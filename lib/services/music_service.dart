import '../models/music_model.dart';

class MusicService {
  static final MusicService _instance = MusicService._internal();
  
  factory MusicService() {
    return _instance;
  }
  
  MusicService._internal();
  
  List<Music> _recentlyPlayed = [
    Music(
      id: '1',
      title: 'Lofi Beats',
      artist: 'Chillhop Music',
      album: 'Lofi Collection',
      imageUrl: 'https://picsum.photos/200/200?random=1',
      audioUrl: '',
      duration: const Duration(minutes: 3, seconds: 45),
      genre: 'Lofi',
      isFavorite: true,
    ),
    Music(
      id: '2',
      title: 'Pop Hits 2024',
      artist: 'Various Artists',
      album: 'Pop Now',
      imageUrl: 'https://picsum.photos/200/200?random=2',
      audioUrl: '',
      duration: const Duration(minutes: 4, seconds: 20),
      genre: 'Pop',
    ),
    Music(
      id: '3',
      title: 'Jazz Classics',
      artist: 'Miles Davis',
      album: 'Kind of Blue',
      imageUrl: 'https://picsum.photos/200/200?random=3',
      audioUrl: '',
      duration: const Duration(minutes: 5, seconds: 15),
      genre: 'Jazz',
      isFavorite: true,
    ),
  ];
  
  Music _nowPlaying = Music(
    id: '4',
    title: 'Midnight City',
    artist: 'M83',
    album: 'Hurry Up, We\'re Dreaming',
    imageUrl: 'https://picsum.photos/200/200?random=4',
    audioUrl: '',
    duration: const Duration(minutes: 4, seconds: 3),
    genre: 'Electronic',
  );
  
  List<Playlist> _playlists = [
    Playlist(
      id: '1',
      name: 'Favorit Saya',
      description: 'Koleksi lagu favorit',
      coverImage: 'https://picsum.photos/200/200?random=5',
      songs: [],
      creator: 'Anda',
      songCount: 24,
    ),
    Playlist(
      id: '2',
      name: 'Olahraga',
      description: 'Musik untuk berolahraga',
      coverImage: 'https://picsum.photos/200/200?random=6',
      songs: [],
      creator: 'Anda',
      songCount: 18,
    ),
  ];
  
  // Getter methods
  List<Music> getRecentlyPlayed() => List.from(_recentlyPlayed);
  
  Music getNowPlaying() => _nowPlaying;
  
  List<Playlist> getPlaylists() => List.from(_playlists);
  
  // Action methods
  void toggleFavorite(String musicId) {
    int index = _recentlyPlayed.indexWhere((music) => music.id == musicId);
    if (index != -1) {
      _recentlyPlayed[index] = _recentlyPlayed[index].copyWith(
        isFavorite: !_recentlyPlayed[index].isFavorite,
      );
    }
    
    // Also update now playing if it's the same music
    if (_nowPlaying.id == musicId) {
      _nowPlaying = _nowPlaying.copyWith(
        isFavorite: !_nowPlaying.isFavorite,
      );
    }
  }
  
  void playMusic(Music music) {
    _nowPlaying = music;
    
    // Add to recently played if not already there
    if (!_recentlyPlayed.any((m) => m.id == music.id)) {
      _recentlyPlayed.insert(0, music);
      if (_recentlyPlayed.length > 10) {
        _recentlyPlayed.removeLast();
      }
    }
  }
  
  void addToPlaylist(String playlistId, Music music) {
    final index = _playlists.indexWhere((playlist) => playlist.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final updatedSongs = List<Music>.from(playlist.songs)..add(music);
      
      _playlists[index] = Playlist(
        id: playlist.id,
        name: playlist.name,
        description: playlist.description,
        coverImage: playlist.coverImage,
        songs: updatedSongs,
        creator: playlist.creator,
        songCount: playlist.songCount + 1,
      );
    }
  }
  
  void createPlaylist(String name, String description) {
    final newPlaylist = Playlist(
      id: (_playlists.length + 1).toString(),
      name: name,
      description: description,
      coverImage: 'https://picsum.photos/200/200?random=${_playlists.length + 6}',
      songs: [],
      creator: 'Anda',
      songCount: 0,
    );
    _playlists.add(newPlaylist);
  }
  
  void removeFromPlaylist(String playlistId, String musicId) {
    final index = _playlists.indexWhere((playlist) => playlist.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final updatedSongs = playlist.songs.where((music) => music.id != musicId).toList();
      
      _playlists[index] = Playlist(
        id: playlist.id,
        name: playlist.name,
        description: playlist.description,
        coverImage: playlist.coverImage,
        songs: updatedSongs,
        creator: playlist.creator,
        songCount: playlist.songCount - 1,
      );
    }
  }
  
  void deletePlaylist(String playlistId) {
    _playlists.removeWhere((playlist) => playlist.id == playlistId);
  }
}