import '../models/wallpaper.dart';
import 'dart:math';

final List<String> mockImages = [
  'assets/wallpapers/naturaleza1.jpg',
  'assets/wallpapers/ciudad1.jpg',
  'assets/wallpapers/arte1.jpg',
];

final List<String> categories = [
  'Naturaleza',
  'Urbano',
  'Arte',
  'Futurista',
  'Espacio',
  'Anime',
];

final wallpapers = List.generate(100, (index) {
  final random = Random();
  return Wallpaper(
    title: 'Fondo #$index',
    category: categories[random.nextInt(categories.length)],
    imagePath: mockImages[random.nextInt(mockImages.length)],
    likes: random.nextInt(300),
    downloads: random.nextInt(150),
  );
});
