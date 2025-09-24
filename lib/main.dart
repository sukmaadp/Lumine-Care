import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/cart.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luminé',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return DashboardPage(email: args ?? "user@mail.com");
        },
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
