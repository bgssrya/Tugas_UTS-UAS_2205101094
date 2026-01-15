import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/now_playing_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/music_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/music_service.dart';
import 'explore_page.dart';
import 'library_page.dart';
import 'profile_page.dart';
import '../models/music_model.dart';
import '../widgets/custom_button.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MusicService _musicService = MusicService();
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _showSearchBar ? _buildSearchAppBar() : _buildMainAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Welcome Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang,',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Apa yang ingin Anda dengarkan hari ini?',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.onSurface,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Now Playing Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sedang Diputar',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const NowPlayingCard(),
                ],
              ),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Akses Cepat',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      QuickActionCard(
                        icon: Icons.music_note,
                        title: 'Playlist Saya',
                        color: AppColors.primary,
                        routeName: '/library',
                      ),
                      QuickActionCard(
                        icon: Icons.favorite,
                        title: 'Favorit',
                        color: AppColors.secondary,
                        routeName: '/library',
                        arguments: {'tab': 1},
                      ),
                      QuickActionCard(
                        icon: Icons.trending_up,
                        title: 'Trending',
                        color: AppColors.accent,
                        routeName: '/explore',
                      ),
                      QuickActionCard(
                        icon: Icons.explore,
                        title: 'Jelajahi',
                        color: const Color(0xFF9D4EDD),
                        routeName: '/explore',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Recently Played
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Baru Saja Diputar',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onBackground,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Melihat semua riwayat'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        child: const Text(
                          'Lihat Semua',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _musicService
                          .getRecentlyPlayed()
                          .map(
                            (music) => Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: MusicCard(
                                music: music,
                                width: 180,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recommended For You
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rekomendasi untuk Anda',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        MusicCard(
                          music: Music(
                            id: '5',
                            title: 'Indie Vibes',
                            artist: 'Indie Artists',
                            album: 'Indie Collection',
                            imageUrl: 'https://picsum.photos/200/200?random=6',
                            audioUrl: '',
                            duration: const Duration(minutes: 3, seconds: 30),
                            genre: 'Indie',
                          ),
                          width: 180,
                        ),
                        const SizedBox(width: 16),
                        MusicCard(
                          music: Music(
                            id: '6',
                            title: 'Rock Classics',
                            artist: 'Rock Legends',
                            album: 'Rock Anthology',
                            imageUrl: 'https://picsum.photos/200/200?random=7',
                            audioUrl: '',
                            duration: const Duration(minutes: 4, seconds: 45),
                            genre: 'Rock',
                          ),
                          width: 180,
                        ),
                        const SizedBox(width: 16),
                        MusicCard(
                          music: Music(
                            id: '7',
                            title: 'Hip Hop Beats',
                            artist: 'Various Artists',
                            album: 'Hip Hop Mix',
                            imageUrl: 'https://picsum.photos/200/200?random=8',
                            audioUrl: '',
                            duration: const Duration(minutes: 3, seconds: 15),
                            genre: 'Hip Hop',
                          ),
                          width: 180,
                        ),
                        const SizedBox(width: 16),
                        MusicCard(
                          music: Music(
                            id: '8',
                            title: 'Chill Lo-fi',
                            artist: 'Study Beats',
                            album: 'Focus Music',
                            imageUrl: 'https://picsum.photos/200/200?random=9',
                            audioUrl: '',
                            duration: const Duration(minutes: 2, seconds: 45),
                            genre: 'Lo-fi',
                          ),
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popular Playlists
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Playlist Populer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      _buildPlaylistCard(
                        'Workout Mix',
                        'Energi untuk olahraga',
                        'https://picsum.photos/200/200?random=10',
                        '50 lagu',
                      ),
                      _buildPlaylistCard(
                        'Relax & Unwind',
                        'Santai dan tenang',
                        'https://picsum.photos/200/200?random=11',
                        '45 lagu',
                      ),
                      _buildPlaylistCard(
                        'Party Hits',
                        'Lagu pesta terbaik',
                        'https://picsum.photos/200/200?random=12',
                        '60 lagu',
                      ),
                      _buildPlaylistCard(
                        'Acoustic Sessions',
                        'Versi akustik',
                        'https://picsum.photos/200/200?random=13',
                        '40 lagu',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar _buildMainAppBar() {
    return AppBar(
      title: const Text(
        'Rungokno Tembang',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: AppColors.surface.withOpacity(0.8),
      foregroundColor: AppColors.onBackground,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showSearchBar = true;
            });
          },
          icon: const Icon(Icons.search, size: 28),
          tooltip: 'Cari musik',
        ),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Membuka notifikasi'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
          icon: const Icon(Icons.notifications_outlined, size: 28),
          tooltip: 'Notifikasi',
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.cardBackground,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Menu Cepat',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onBackground,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.settings, color: AppColors.accent),
                        title: const Text('Pengaturan', style: TextStyle(color: AppColors.onBackground)),
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Membuka pengaturan'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.dark_mode, color: AppColors.accent),
                        title: const Text('Mode Gelap', style: TextStyle(color: AppColors.onBackground)),
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: AppColors.accent,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.equalizer, color: AppColors.accent),
                        title: const Text('Equalizer', style: TextStyle(color: AppColors.onBackground)),
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Membuka equalizer'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Tutup',
                        onPressed: () => Navigator.pop(context),
                        hasGradient: false,
                        backgroundColor: AppColors.surface,
                        textColor: AppColors.onSurface,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.menu, size: 28),
          tooltip: 'Menu',
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface.withOpacity(0.9),
      foregroundColor: AppColors.onBackground,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            _showSearchBar = false;
            _searchController.clear();
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        style: const TextStyle(
          color: AppColors.onBackground,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Cari lagu, artis, atau album...',
          hintStyle: TextStyle(
            color: AppColors.onSurface.withOpacity(0.6),
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Handle search
        },
        onSubmitted: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mencari: $value'),
              backgroundColor: AppColors.primary,
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
          },
        ),
      ],
    );
  }

  Widget _buildPlaylistCard(String title, String subtitle, String imageUrl, String songCount) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Membuka playlist: $title'),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onBackground,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurface.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        size: 14,
                        color: AppColors.onSurface,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        songCount,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Memutar playlist: $title'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.accentGradient,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}