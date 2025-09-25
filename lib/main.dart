import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/cart.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/cart_page.dart';
import 'pages/device_info_page.dart';
import 'pages/shared_preferences_page.dart';
import 'pages/feedback_page.dart'; // ✅ Tambahkan ini

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    // kasih delay sedikit biar SplashPage kelihatan
    await Future.delayed(const Duration(seconds: 2));
    return email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luminé',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder<String>(
        future: _checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // tampilkan SplashPage selama cek login
            return const SplashPage();
          }

          final email = snapshot.data ?? '';
          if (email.isNotEmpty) {
            // Sudah login → ke dashboard
            return DashboardPage(email: email);
          } else {
            // Belum login → ke halaman login
            return const LoginPage();
          }
        },
      ),
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return DashboardPage(email: args ?? "user@mail.com");
        },
        '/cart': (context) => const CartPage(),
        '/device_info': (context) => const DeviceInfoPage(),
        '/shared': (context) => const SharedPreferencesPage(),
        '/feedback': (context) => const FeedbackPage(),
      },
    );
  }
}
