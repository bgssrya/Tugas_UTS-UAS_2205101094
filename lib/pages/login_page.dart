import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_button.dart';
import '../theme/app_colors.dart';
import '../services/navigation_service.dart';
import '../pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );
    
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );
    
    _scale = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password harus diisi'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulasi proses login
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      NavigationService.navigateReplacement('/home');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil! Selamat datang di Rungokno Tembang 🎵'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ScaleTransition(
              scale: _scale,
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: AppColors.accentGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.music_note,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // App Title
                      const Column(
                        children: [
                          Text(
                            'Rungokno Tembang',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onBackground,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "🎵 Dengarkan musik tanpa batas 🎵",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.onSurface,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Email Input
                      InputField(
                        label: "Email",
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Password Input
                      InputField(
                        label: "Password",
                        obscure: _obscurePassword,
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
                        hintText: 'Minimal 6 karakter',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password harus diisi';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Login Button
                      CustomButton(
                        text: "Masuk ke Akun",
                        onPressed: _handleLogin,
                        icon: Icons.login,
                        isLoading: _isLoading,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.onSurface.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "ATAU",
                              style: TextStyle(
                                color: AppColors.onSurface.withOpacity(0.6),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.onSurface.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Social Login Buttons
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(
                            icon: Icons.g_translate,
                            onPressed: _handleGoogleLogin,
                            tooltip: 'Login dengan Google',
                          ),
                          SizedBox(width: 16),
                          SocialButton(
                            icon: Icons.facebook,
                            onPressed: _handleFacebookLogin,
                            tooltip: 'Login dengan Facebook',
                          ),
                          SizedBox(width: 16),
                          SocialButton(
                            icon: Icons.apple,
                            onPressed: _handleAppleLogin,
                            tooltip: 'Login dengan Apple',
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sign Up Link
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppColors.cardBackground,
                              title: const Text(
                                'Daftar Akun Baru',
                                style: TextStyle(
                                  color: AppColors.onBackground,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Fitur pendaftaran akun baru akan segera hadir dalam versi selanjutnya!',
                                    style: TextStyle(
                                      color: AppColors.onSurface,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    text: "Mengerti",
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Belum punya akun? ",
                                style: TextStyle(
                                  color: AppColors.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "Daftar Sekarang",
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _handleGoogleLogin() {
  // Implementation for Google login
}

void _handleFacebookLogin() {
  // Implementation for Facebook login
}

void _handleAppleLogin() {
  // Implementation for Apple login
}