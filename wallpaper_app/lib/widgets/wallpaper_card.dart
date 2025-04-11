import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../theme/app_colors.dart';
import '../screens/wallpaper_detail.dart';

class WallpaperCard extends StatefulWidget {
  final Wallpaper wallpaper;

  const WallpaperCard({super.key, required this.wallpaper});

  @override
  State<WallpaperCard> createState() => _WallpaperCardState();
}

class _WallpaperCardState extends State<WallpaperCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
                      child: WallpaperDetail(imagePath: widget.wallpaper.imagePath),
                    ),
                  ),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.azulNoche3.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Hero(
                    tag: widget.wallpaper.imagePath,
                    child: Image.asset(
                      widget.wallpaper.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.wallpaper.title,
                        style: const TextStyle(
                          color: AppColors.blanco,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.wallpaper.category,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.redAccent, size: 16),
                          const SizedBox(width: 4),
                          Text('${widget.wallpaper.likes}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(width: 12),
                          const Icon(Icons.download, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text('${widget.wallpaper.downloads}', style: const TextStyle(color: Colors.white70)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
