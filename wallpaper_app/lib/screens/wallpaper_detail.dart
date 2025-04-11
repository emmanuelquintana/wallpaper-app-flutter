import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WallpaperDetail extends StatefulWidget {
  final String imagePath;

  const WallpaperDetail({super.key, required this.imagePath});

  @override
  State<WallpaperDetail> createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> with TickerProviderStateMixin {
  late final AnimationController _likeController;
  late final AnimationController _shareController;
  late final AnimationController _downloadController;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _shareController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _downloadController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
  }

  @override
  void dispose() {
    _likeController.dispose();
    _shareController.dispose();
    _downloadController.dispose();
    super.dispose();
  }

  void _playAnimation(AnimationController controller, String message) async {
    await controller.forward();
    await controller.reverse();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.negroProfundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Hero(
                  tag: widget.imagePath,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _animatedButton(
                  controller: _likeController,
                  icon: Icons.favorite,
                  label: 'Me gusta',
                  onPressed: () => _playAnimation(_likeController, '💖 Agregado a favoritos'),
                ),
                _animatedButton(
                  controller: _shareController,
                  icon: Icons.share,
                  label: 'Compartir',
                  onPressed: () => _playAnimation(_shareController, '📤 Compartir próximamente'),
                ),
                _animatedButton(
                  controller: _downloadController,
                  icon: Icons.download,
                  label: 'Descargar',
                  onPressed: () => _playAnimation(_downloadController, '⬇️ Requiere ver un anuncio'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedButton({
    required AnimationController controller,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    final animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    return GestureDetector(
      onTap: onPressed,
      child: ScaleTransition(
        scale: animation,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.azulNoche2.withOpacity(0.9),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
