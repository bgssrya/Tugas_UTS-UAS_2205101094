import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/music_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../services/music_service.dart';
import '../models/music_model.dart'; // ✅ Playlist & Music dari sini SAJA

class LibraryPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const LibraryPage({super.key, this.arguments});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _currentIndex = 2;
  int _selectedTab = 0;

  final MusicService _musicService = MusicService();
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.arguments?['tab'] ?? 0;
    _pageController = PageController(initialPage: _selectedTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.onBackground,
        title: const Text(
          'Perpustakaan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreatePlaylistDialog,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showLibrarySettings,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedTab = index);
              },
              children: [
                _buildPlaylistsTab(),
                _buildFavoritesTab(),
                _buildDownloadsTab(),
              ],
            ),
          ),
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

  // ================= TAB BAR =================

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabButton('Playlist', 0),
          _buildTabButton('Favorit', 1),
          _buildTabButton('Unduhan', 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final bool isActive = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedTab = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isActive ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color:
                    isActive ? AppColors.onPrimary : AppColors.onSurface,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= PLAYLIST TAB =================

  Widget _buildPlaylistsTab() {
    final playlists = _musicService.getPlaylists();

    if (playlists.isEmpty) {
      return _buildEmptyState(
        Icons.playlist_add,
        'Belum Ada Playlist',
        'Buat playlist pertama Anda',
        'Buat Playlist',
        _showCreatePlaylistDialog,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: playlists.length,
      itemBuilder: (_, index) {
        return _buildPlaylistItem(playlists[index]);
      },
    );
  }

  Widget _buildPlaylistItem(Playlist playlist) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            playlist.coverImage,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          playlist.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.onBackground,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          '${playlist.songCount} lagu • ${playlist.creator}',
          style: const TextStyle(color: AppColors.onSurface),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handlePlaylistMenu(value, playlist),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'play', child: Text('Putar')),
            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),
      ),
    );
  }

  // ================= FAVORITES =================

  Widget _buildFavoritesTab() {
    final favorites = _musicService
        .getRecentlyPlayed()
        .where((m) => m.isFavorite)
        .toList();

    if (favorites.isEmpty) {
      return _buildEmptyState(
        Icons.favorite_border,
        'Belum Ada Favorit',
        'Tambahkan lagu ke favorit',
        'Jelajahi Musik',
        () {},
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: favorites.length,
      itemBuilder: (_, index) {
        return MusicCard(
          music: favorites[index],
          width: double.infinity,
        );
      },
    );
  }

  // ================= DOWNLOADS =================

  Widget _buildDownloadsTab() {
    return _buildEmptyState(
      Icons.download,
      'Belum Ada Unduhan',
      'Unduh lagu untuk offline',
      'Jelajahi Musik',
      () {},
    );
  }

  // ================= EMPTY STATE =================

  Widget _buildEmptyState(
    IconData icon,
    String title,
    String desc,
    String btnText,
    VoidCallback onTap,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: AppColors.onSurface),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          Text(desc,
              style:
                  const TextStyle(color: AppColors.onSurface)),
          const SizedBox(height: 24),
          CustomButton(
            text: btnText,
            onPressed: onTap,
            width: 200,
          ),
        ],
      ),
    );
  }

  // ================= DIALOGS =================

  void _showCreatePlaylistDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text('Buat Playlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              label: 'Nama Playlist',
              controller: nameController,
            ),
            const SizedBox(height: 12),
            InputField(
              label: 'Deskripsi',
              controller: descController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          CustomButton(
            text: 'Buat',
            width: 100,
            onPressed: () {
              if (nameController.text.isEmpty) return;

              _musicService.createPlaylist(
                nameController.text,
                descController.text,
              );

              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _handlePlaylistMenu(String value, Playlist playlist) {
    switch (value) {
      case 'play':
        break;
      case 'delete':
        _musicService.deletePlaylist(playlist.id);
        setState(() {});
        break;
    }
  }

  void _showLibrarySettings() {}
}
