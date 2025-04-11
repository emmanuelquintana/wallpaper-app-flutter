class Wallpaper {
  final String title;
  final String category;
  final String imagePath;
  final int likes;
  final int downloads;

  Wallpaper({
    required this.title,
    required this.category,
    required this.imagePath,
    this.likes = 0,
    this.downloads = 0,
  });
}
