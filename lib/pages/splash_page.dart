import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

<<<<<<< HEAD
    Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');

    if (!mounted) return;

    if (email != null && email.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: email);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
=======
    //Pindah otomatis ke Login
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
>>>>>>> 908f62806a50c4e3bcf7afd957b7cf64fdb5c0f2
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
<<<<<<< HEAD
=======
                //Logo Aplikasi
>>>>>>> 908f62806a50c4e3bcf7afd957b7cf64fdb5c0f2
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/logo.jpg",
                    height: 130,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.spa, size: 90, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
<<<<<<< HEAD
=======

                //Nama Aplikasi
>>>>>>> 908f62806a50c4e3bcf7afd957b7cf64fdb5c0f2
                const Text(
                  "Luminé Care",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
<<<<<<< HEAD
=======

                //Nama Pembuat
>>>>>>> 908f62806a50c4e3bcf7afd957b7cf64fdb5c0f2
                const Text(
                  "Creat by: Sukma Dwi Pangesti",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 30),
<<<<<<< HEAD
=======

                //Loading Indicator
>>>>>>> 908f62806a50c4e3bcf7afd957b7cf64fdb5c0f2
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
