import 'package:flutter/material.dart';
import '../data/wallpapers.dart';
import '../models/wallpaper.dart';
import '../theme/app_colors.dart';
import '../widgets/wallpaper_card.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  // Simulamos wallpapers descargados
  List<Wallpaper> get downloadedWallpapers => wallpapers.where((w) => w.downloads > 80).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.negroProfundo,
      appBar: AppBar(
        title: const Text('Mis Descargas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: downloadedWallpapers.isEmpty
            ? const Center(
                child: Text('No has descargado fondos todavía.', style: TextStyle(color: Colors.white70)),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: downloadedWallpapers.length,
                itemBuilder: (context, index) {
                  return WallpaperCard(
                    key: UniqueKey(),
                    wallpaper: downloadedWallpapers[index],
                  );
                },
              ),
      ),
    );
  }
}
