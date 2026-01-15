import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../services/navigation_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  String _name = 'Pengguna Rungokno';
  String _email = 'pengguna@rungoknotembang.com';
  String _subscription = 'Premium';
  int _songCount = 128;
  int _playlistCount = 24;
  int _minutesPlayed = 1200;
  bool _isDarkMode = true;
  bool _isNotificationsEnabled = true;
  bool _isExplicitContentAllowed = false;
  bool _isAutoPlayEnabled = true;
  bool _isDataSaverEnabled = false;
  bool _isEditingProfile = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _name;
    _emailController.text = _email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _isEditingProfile ? 'Edit Profil' : 'Profil',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
        actions: [
          if (!_isEditingProfile)
            IconButton(
              onPressed: () {
                setState(() {
                  _isEditingProfile = true;
                });
              },
              icon: const Icon(Icons.edit, size: 28),
              tooltip: 'Edit Profil',
            ),
          if (_isEditingProfile)
            IconButton(
              onPressed: _saveProfile,
              icon: const Icon(Icons.check, size: 28),
              tooltip: 'Simpan',
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (_isEditingProfile) _buildEditProfileSection(),
          if (!_isEditingProfile) ...[
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 32),

            // Statistics
            _buildStatisticsSection(),
            const SizedBox(height: 40),

            // Account Section
            _buildSectionTitle('Akun'),
            _buildSettingOption(
              Icons.person_outline,
              'Data Akun',
              'Informasi dan pengaturan akun',
              _showAccountInfo,
            ),
            _buildSettingOption(
              Icons.subscriptions,
              'Langganan',
              _subscription,
              _showSubscriptionInfo,
            ),
            _buildSettingOption(
              Icons.payment,
              'Pembayaran',
              'Metode pembayaran',
              _showPaymentInfo,
            ),
            _buildSettingOption(
              Icons.security,
              'Privasi & Keamanan',
              'Pengaturan privasi',
              _showPrivacySettings,
            ),

            const SizedBox(height: 24),

            // Preferences Section
            _buildSectionTitle('Preferensi'),
            _buildSwitchOption(
              Icons.notifications_outlined,
              'Notifikasi',
              'Aktifkan notifikasi',
              _isNotificationsEnabled,
              (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
            _buildSwitchOption(
              Icons.explicit,
              'Konten Eksplisit',
              'Izinkan konten eksplisit',
              _isExplicitContentAllowed,
              (value) {
                setState(() {
                  _isExplicitContentAllowed = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Konten eksplisit diizinkan' : 'Konten eksplisit dibatasi',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
            _buildSwitchOption(
              Icons.play_circle_outline,
              'Putar Otomatis',
              'Putar lagu berikutnya otomatis',
              _isAutoPlayEnabled,
              (value) {
                setState(() {
                  _isAutoPlayEnabled = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Putar otomatis diaktifkan' : 'Putar otomatis dinonaktifkan',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
            _buildSwitchOption(
              Icons.data_saver_off,
              'Penghemat Data',
              'Kurangi kualitas audio untuk hemat data',
              _isDataSaverEnabled,
              (value) {
                setState(() {
                  _isDataSaverEnabled = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Penghemat data diaktifkan' : 'Penghemat data dinonaktifkan',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // App Settings Section
            _buildSectionTitle('Aplikasi'),
            _buildSettingOption(
              Icons.language,
              'Bahasa',
              'Bahasa Indonesia',
              _showLanguageSelection,
            ),
            _buildSwitchOption(
              Icons.dark_mode,
              'Mode Gelap',
              'Tampilan gelap',
              _isDarkMode,
              (value) {
                setState(() {
                  _isDarkMode = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Mode gelap diaktifkan' : 'Mode terang diaktifkan',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
            _buildSettingOption(
              Icons.storage,
              'Penyimpanan',
              '2.4 GB digunakan',
              _showStorageInfo,
            ),
            _buildSettingOption(
              Icons.equalizer,
              'Equalizer',
              'Pengaturan suara',
              _showEqualizerSettings,
            ),

            const SizedBox(height: 24),

            // Support Section
            _buildSectionTitle('Dukungan'),
            _buildSettingOption(
              Icons.help_outline,
              'Bantuan & Dukungan',
              'Pusat bantuan',
              _showHelpCenter,
            ),
            _buildSettingOption(
              Icons.description,
              'Syarat & Ketentuan',
              'Baca syarat penggunaan',
              _showTermsAndConditions,
            ),
            _buildSettingOption(
              Icons.privacy_tip,
              'Kebijakan Privasi',
              'Baca kebijakan privasi',
              _showPrivacyPolicy,
            ),
            _buildSettingOption(
              Icons.info_outline,
              'Tentang Aplikasi',
              'Versi 1.0.0',
              _showAboutApp,
            ),

            const SizedBox(height: 40),

            // Logout Button
            _buildLogoutButton(),

            const SizedBox(height: 32),
          ],
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

  Widget _buildEditProfileSection() {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: _changeProfilePicture,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        InputField(
          label: "Nama Lengkap",
          controller: _nameController,
          prefixIcon: Icons.person,
        ),
        const SizedBox(height: 20),
        InputField(
          label: "Email",
          controller: _emailController,
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: "Batal",
                onPressed: () {
                  setState(() {
                    _isEditingProfile = false;
                    _nameController.text = _name;
                    _emailController.text = _email;
                  });
                },
                hasGradient: false,
                backgroundColor: AppColors.surface,
                textColor: AppColors.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                text: "Simpan",
                onPressed: _saveProfile,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.accentGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.onBackground,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _email,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.onSurface,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _subscription,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _upgradeSubscription,
                  icon: const Icon(
                    Icons.upgrade,
                    color: AppColors.accent,
                    size: 16,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Upgrade',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(_songCount.toString(), 'Lagu'),
          Container(
            height: 40,
            width: 1,
            color: AppColors.onSurface.withOpacity(0.3),
          ),
          _buildStatItem(_playlistCount.toString(), 'Playlist'),
          Container(
            height: 40,
            width: 1,
            color: AppColors.onSurface.withOpacity(0.3),
          ),
          _buildStatItem('${_minutesPlayed}K', 'Menit'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.onBackground,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.onSurface,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.accent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.onSurface,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchOption(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.accent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 12,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.accent,
          inactiveTrackColor: AppColors.onSurface.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            AppColors.error.withOpacity(0.1),
            AppColors.error.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: AppColors.error.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: AppColors.error,
        ),
        title: Text(
          'Keluar',
          style: TextStyle(
            color: AppColors.error,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        onTap: _confirmLogout,
      ),
    );
  }

  void _saveProfile() {
    setState(() {
      _name = _nameController.text;
      _email = _emailController.text;
      _isEditingProfile = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Ganti Foto Profil',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.accent),
              title: const Text('Ambil Foto', style: TextStyle(color: AppColors.onBackground)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengambil foto...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.accent),
              title: const Text('Pilih dari Galeri', style: TextStyle(color: AppColors.onBackground)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Memilih dari galeri...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: AppColors.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  void _upgradeSubscription() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Upgrade ke Premium',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Dapatkan akses ke fitur premium:',
              style: TextStyle(color: AppColors.onSurface),
            ),
            const SizedBox(height: 16),
            _buildPremiumFeature('🎵 Musik tanpa iklan'),
            _buildPremiumFeature('📥 Unduh untuk offline'),
            _buildPremiumFeature('🎧 Kualitas audio tinggi'),
            _buildPremiumFeature('📱 Dengarkan di semua perangkat'),
            const SizedBox(height: 16),
            const Text(
              'Hanya Rp 49.999/bulan',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Nanti',
              style: TextStyle(color: AppColors.onSurface),
            ),
          ),
          CustomButton(
            text: 'Upgrade',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proses upgrade...'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            width: 120,
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 20),
          const SizedBox(width: 8),
          Text(
            feature,
            style: const TextStyle(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Konfirmasi Keluar',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun?',
          style: TextStyle(color: AppColors.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: AppColors.onSurface),
            ),
          ),
          CustomButton(
            text: 'Keluar',
            onPressed: () {
              Navigator.pop(context);
              NavigationService.navigateAndRemoveUntil('/');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil keluar dari akun'),
                  backgroundColor: AppColors.success,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            backgroundColor: AppColors.error,
            width: 100,
          ),
        ],
      ),
    );
  }

  void _showAccountInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Informasi Akun',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $_name', style: const TextStyle(color: AppColors.onSurface)),
            Text('Email: $_email', style: const TextStyle(color: AppColors.onSurface)),
            Text('Langganan: $_subscription', style: const TextStyle(color: AppColors.onSurface)),
            Text('Tanggal Bergabung: 1 Januari 2024', style: const TextStyle(color: AppColors.onSurface)),
          ],
        ),
        actions: [
          CustomButton(
            text: 'Tutup',
            onPressed: () => Navigator.pop(context),
            width: 100,
          ),
        ],
      ),
    );
  }

  void _showSubscriptionInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Informasi Langganan',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $_subscription', style: const TextStyle(color: AppColors.onSurface)),
            Text('Perpanjangan: 1 Februari 2024', style: const TextStyle(color: AppColors.onSurface)),
            Text('Harga: Rp 49.999/bulan', style: const TextStyle(color: AppColors.onSurface)),
            const SizedBox(height: 16),
            const Text(
              'Fitur Premium:',
              style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _buildPremiumFeature('Tanpa iklan'),
            _buildPremiumFeature('Unduh offline'),
            _buildPremiumFeature('Kualitas tinggi'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal Langganan',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          CustomButton(
            text: 'Tutup',
            onPressed: () => Navigator.pop(context),
            width: 100,
          ),
        ],
      ),
    );
  }

  void _showPaymentInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka pengaturan pembayaran'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka pengaturan privasi'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showLanguageSelection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Pilih Bahasa',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Bahasa Indonesia',
                style: TextStyle(color: AppColors.onBackground),
              ),
              trailing: const Icon(Icons.check, color: AppColors.accent),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'English',
                style: TextStyle(color: AppColors.onBackground),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bahasa diubah ke English'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showStorageInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Penggunaan Penyimpanan',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CircularProgressIndicator(
              value: 0.6,
              strokeWidth: 8,
              color: AppColors.accent,
              backgroundColor: AppColors.surface,
            ),
            const SizedBox(height: 16),
            const Text(
              '2.4 GB / 4 GB digunakan',
              style: TextStyle(color: AppColors.onSurface),
            ),
            const SizedBox(height: 8),
            const Text(
              '60% dari total penyimpanan',
              style: TextStyle(color: AppColors.onSurface, fontSize: 12),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Bersihkan Cache',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache berhasil dibersihkan'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  void _showEqualizerSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka pengaturan equalizer'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showHelpCenter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka pusat bantuan'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Syarat & Ketentuan',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...',
              style: const TextStyle(color: AppColors.onSurface),
            ),
          ),
        ),
        actions: [
          CustomButton(
            text: 'Tutup',
            onPressed: () => Navigator.pop(context),
            width: 100,
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(color: AppColors.onBackground),
        ),
        content: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Text(
              'Kebijakan privasi kami menjelaskan bagaimana kami mengumpulkan, '
              'menggunakan, dan melindungi informasi pribadi Anda...',
              style: const TextStyle(color: AppColors.onSurface),
            ),
          ),
        ),
        actions: [
          CustomButton(
            text: 'Tutup',
            onPressed: () => Navigator.pop(context),
            width: 100,
          ),
        ],
      ),
    );
  }

  void _showAboutApp() {
    showAboutDialog(
      context: context,
      applicationName: 'Rungokno Tembang',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Rungokno Tembang. All rights reserved.',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.accentGradient,
        ),
        child: const Icon(
          Icons.music_note,
          color: Colors.white,
          size: 30,
        ),
      ),
      children: [
        const SizedBox(height: 16),
        const Text(
          'Aplikasi streaming musik modern yang membawakan pengalaman mendengarkan musik terbaik.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.onSurface),
        ),
        const SizedBox(height: 16),
        const Text(
          'Fitur Unggulan:',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildPremiumFeature('Streaming musik tanpa batas'),
        _buildPremiumFeature('Rekomendasi personal'),
        _buildPremiumFeature('Playlist yang dapat disesuaikan'),
        _buildPremiumFeature('Kualitas audio HD'),
      ],
    );
  }
}