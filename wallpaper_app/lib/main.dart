import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';
import 'screens/liked_screen.dart';
import 'screens/downloads_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fondos de Pantalla',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/perfil': (context) => const ProfileScreen(),
        '/me-gusta': (context) => const LikedScreen(),
        '/descargas': (context) => const DownloadsScreen(),
      },
    );
  }
}
