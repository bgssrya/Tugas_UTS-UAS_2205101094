import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../models/music_model.dart';
import '../services/music_service.dart';
import '../services/navigation_service.dart';

import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';

class MusicCard extends StatefulWidget {
  final Music music;
  final VoidCallback? onTap;
  final bool showActions;
  final double width;
  final bool showArtist;

  const MusicCard({
    super.key,
    required this.music,
    this.onTap,
    this.showActions = true,
    this.width = 160,
    this.showArtist = true,
  });

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  final MusicService _musicService = MusicService();
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.music.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _openPlayer,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCover(),
            _buildInfo(context),
          ],
        ),
      ),
    );
  }

  // ================= COVER =================

  Widget _buildCover() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          SizedBox(
            height: widget.width * 0.75,
            width: double.infinity,
            child: Image.network(
              widget.music.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.music_note, size: 40),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${widget.music.duration.inMinutes}:${(widget.music.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO =================

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.music.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.onBackground,
              fontFamily: 'Poppins',
            ),
          ),
          if (widget.showArtist) ...[
            const SizedBox(height: 4),
            Text(
              widget.music.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.onSurface,
              ),
            ),
          ],
          if (widget.showActions) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _playButton(),
                Row(
                  children: [
                    _favoriteButton(context),
                    IconButton(
                      icon: const Icon(Icons.playlist_add),
                      onPressed: () => _showAddToPlaylist(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ================= BUTTONS =================

  Widget _playButton() {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.accentGradient,
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
      onPressed: _openPlayer,
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? AppColors.secondary : AppColors.onSurface,
      ),
      onPressed: () {
        setState(() => _isFavorite = !_isFavorite);
        _musicService.toggleFavorite(widget.music.id);
      },
    );
  }

  // ================= NAVIGATION =================

  void _openPlayer() {
    _musicService.playMusic(widget.music);
    NavigationService.navigateTo('/player', arguments: widget.music);
  }

  // ================= PLAYLIST =================

  void _showAddToPlaylist(BuildContext context) {
    final playlists = _musicService.getPlaylists();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SizedBox(
        height: 400,
        child: ListView(
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
      ),
    );
  }
}
