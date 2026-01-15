import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/music_model.dart';
import '../services/music_service.dart';
import '../services/navigation_service.dart';

class NowPlayingCard extends StatefulWidget {
  const NowPlayingCard({super.key});

  @override
  State<NowPlayingCard> createState() => _NowPlayingCardState();
}

class _NowPlayingCardState extends State<NowPlayingCard> {
  final MusicService _musicService = MusicService();
  bool _isPlaying = true;
  double _progress = 0.3;

  @override
  Widget build(BuildContext context) {
    final nowPlaying = _musicService.getNowPlaying();

    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo('/player', arguments: nowPlaying);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Album Cover
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(nowPlaying.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Music Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nowPlaying.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onBackground,
                          fontFamily: 'Poppins',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        nowPlaying.artist,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.onSurface,
                          fontFamily: 'Poppins',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Progress Bar
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          Slider(
                            value: _progress,
                            onChanged: (value) {
                              setState(() {
                                _progress = value;
                              });
                            },
                            activeColor: AppColors.accent,
                            inactiveColor: AppColors.onSurface.withOpacity(0.2),
                            thumbColor: AppColors.accent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${(_progress * nowPlaying.duration.inMinutes).toInt()}:${((_progress * nowPlaying.duration.inSeconds) % 60).toInt().toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurface.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '${nowPlaying.duration.inMinutes}:${(nowPlaying.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Controls
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Lagu sebelumnya'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: AppColors.onSurface,
                              size: 28,
                            ),
                            tooltip: 'Lagu sebelumnya',
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _isPlaying ? 'Diputar ▶️' : 'Dijeda ⏸️',
                                  ),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.accentGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Lagu berikutnya'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: AppColors.onSurface,
                              size: 28,
                            ),
                            tooltip: 'Lagu berikutnya',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}