import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../models/music_model.dart';
import '../services/music_service.dart';

import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';

class MusicPlayerPage extends StatefulWidget {
  final Music music;

  const MusicPlayerPage({
    super.key,
    required this.music,
  });

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  bool _isPlaying = true;
  bool _isLiked = false;
  bool _isShuffle = false;
  bool _isRepeat = false;

  double _volume = 0.7;
  double _progress = 0.3;

  final MusicService _musicService = MusicService();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _scale = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildAlbumArt(),
            _buildMusicInfo(),
            _buildProgress(),
            _buildMainControls(),
            _buildSecondaryControls(),
            _buildLyricsButton(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.onBackground),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Sedang Diputar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.onBackground,
              fontFamily: 'Poppins',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.onBackground),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
    );
  }

  // ================= ALBUM ART =================

  Widget _buildAlbumArt() {
    return Expanded(
      child: Center(
        child: RotationTransition(
          turns: _rotation,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  widget.music.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= MUSIC INFO =================

  Widget _buildMusicInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            widget.music.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.onBackground,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.music.artist,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.music.album,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  // ================= PROGRESS =================

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Slider(
            value: _progress,
            onChanged: (v) => setState(() => _progress = v),
            activeColor: AppColors.accent,
            inactiveColor: AppColors.onSurface.withOpacity(0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(_progress * widget.music.duration.inSeconds ~/ 60)}:${((_progress * widget.music.duration.inSeconds) % 60).toInt().toString().padLeft(2, '0')}',
                style: const TextStyle(color: AppColors.onSurface),
              ),
              Text(
                '${widget.music.duration.inMinutes}:${(widget.music.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: AppColors.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= MAIN CONTROLS =================

  Widget _buildMainControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _iconBtn(Icons.shuffle, _isShuffle, () {
            setState(() => _isShuffle = !_isShuffle);
          }),
          IconButton(
            icon: const Icon(Icons.skip_previous, size: 36),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isPlaying = !_isPlaying;
                _isPlaying ? _controller.repeat() : _controller.stop();
              });
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next, size: 36),
            onPressed: () {},
          ),
          _iconBtn(
            _isRepeat ? Icons.repeat_one : Icons.repeat,
            _isRepeat,
            () => setState(() => _isRepeat = !_isRepeat),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, bool active, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, size: 28),
      color: active ? AppColors.accent : AppColors.onSurface,
      onPressed: onTap,
    );
  }

  // ================= SECONDARY =================

  Widget _buildSecondaryControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? AppColors.secondary : AppColors.onSurface,
            ),
            onPressed: () {
              setState(() => _isLiked = !_isLiked);
              _musicService.toggleFavorite(widget.music.id);
            },
          ),
          Row(
            children: [
              const Icon(Icons.volume_down),
              SizedBox(
                width: 100,
                child: Slider(
                  value: _volume,
                  onChanged: (v) => setState(() => _volume = v),
                ),
              ),
              const Icon(Icons.volume_up),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.playlist_add),
            onPressed: _showAddToPlaylistDialog,
          ),
        ],
      ),
    );
  }

  // ================= LYRICS =================

  Widget _buildLyricsButton() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: CustomButton(
        text: 'Tampilkan Lirik',
        icon: Icons.mic,
        onPressed: _showLyrics,
        width: double.infinity,
      ),
    );
  }

  // ================= BOTTOMSHEET & DIALOG =================

  void _showMoreOptions() {}

  void _showAddToPlaylistDialog() {
    final playlists = _musicService.getPlaylists();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        padding: const EdgeInsets.all(24),
        children: playlists
            .map(
              (p) => ListTile(
                title: Text(p.name),
                subtitle: Text('${p.songCount} lagu'),
                onTap: () {
                  _musicService.addToPlaylist(p.id, widget.music);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _showLyrics() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Text(
            _getSampleLyrics(),
            style: const TextStyle(color: AppColors.onBackground, height: 1.5),
          ),
        ),
      ),
    );
  }

  String _getSampleLyrics() => 'Sample lyrics...';
}
