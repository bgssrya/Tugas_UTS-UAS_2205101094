import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/music_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/custom_button.dart';
import '../models/music_model.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 1;

  final List<String> genres = [
    'Semua',
    'Pop',
    'Rock',
    'Jazz',
    'Hip Hop',
    'Electronic',
    'R&B',
    'Indie',
    'Lofi',
    'Klasik',
  ];

  int _selectedGenre = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Jelajahi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MusicSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          /// ===== GENRE =====
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final selected = _selectedGenre == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(
                        genres[index],
                        style: TextStyle(
                          color: selected
                              ? AppColors.onPrimary
                              : AppColors.onSurface,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      selected: selected,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      onSelected: (_) {
                        setState(() => _selectedGenre = index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          /// ===== PLAYLIST UNGGULAN =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Playlist Unggulan'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _featuredCard(
                          'Hits Terbaru 2024',
                          'Lagu terbaru yang sedang trend',
                          'https://picsum.photos/300/200?random=14',
                          '50+ lagu',
                        ),
                        const SizedBox(width: 16),
                        _featuredCard(
                          'Top Global',
                          'Lagu populer dunia',
                          'https://picsum.photos/300/200?random=15',
                          '100+ lagu',
                        ),
                        const SizedBox(width: 16),
                        _featuredCard(
                          'Viral TikTok',
                          'Lagu viral TikTok',
                          'https://picsum.photos/300/200?random=16',
                          '30+ lagu',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ===== KATEGORI =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Kategori'),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: const [
                      QuickActionCard(
                        icon: Icons.radio,
                        title: 'Radio',
                        color: Color(0xFF00BCD4),
                        routeName: '/home',
                        isGradient: true,
                      ),
                      QuickActionCard(
                        icon: Icons.live_tv,
                        title: 'Live',
                        color: Color(0xFFFF4081),
                        routeName: '/home',
                        isGradient: true,
                      ),
                      QuickActionCard(
                        icon: Icons.podcasts,
                        title: 'Podcast',
                        color: Color(0xFF4CAF50),
                        routeName: '/home',
                        isGradient: true,
                      ),
                      QuickActionCard(
                        icon: Icons.album,
                        title: 'Album',
                        color: Color(0xFFFF9800),
                        routeName: '/home',
                        isGradient: true,
                      ),
                      QuickActionCard(
                        icon: Icons.people,
                        title: 'Artis',
                        color: Color(0xFF9C27B0),
                        routeName: '/home',
                        isGradient: true,
                      ),
                      QuickActionCard(
                        icon: Icons.bar_chart,
                        title: 'Charts',
                        color: Color(0xFF2196F3),
                        routeName: '/home',
                        isGradient: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// ===== RILIS BARU =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Rilis Baru'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 260,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        MusicCard(
                          width: 200,
                          music: Music(
                            id: '1',
                            title: 'Summer Vibes',
                            artist: 'Various Artist',
                            album: 'Summer',
                            imageUrl:
                                'https://picsum.photos/200/200?random=20',
                            audioUrl: '',
                            duration: const Duration(minutes: 50),
                            genre: 'Pop',
                          ),
                        ),
                        const SizedBox(width: 16),
                        MusicCard(
                          width: 200,
                          music: Music(
                            id: '2',
                            title: 'Deep House',
                            artist: 'DJ Pool',
                            album: 'House',
                            imageUrl:
                                'https://picsum.photos/200/200?random=21',
                            audioUrl: '',
                            duration: const Duration(minutes: 45),
                            genre: 'Electronic',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  /// ===== WIDGET HELPERS =====

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        color: AppColors.onBackground,
      ),
    );
  }

  Widget _featuredCard(
    String title,
    String subtitle,
    String imageUrl,
    String count,
  ) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== SEARCH =====

class MusicSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: CustomButton(
        text: 'Cari "$query"',
        width: 200,
        onPressed: () {},
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = ['Pop', 'Rock', 'Jazz', 'Indie', 'Lofi'];
    final filtered = suggestions
        .where((e) => e.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(filtered[index]),
          onTap: () {
            query = filtered[index];
            showResults(context);
          },
        );
      },
    );
  }
}
