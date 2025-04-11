import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/wallpaper.dart';
import 'wallpaper_card.dart';

class WallpapersGrid extends StatefulWidget {
  final List<Wallpaper> filteredList;

  const WallpapersGrid({super.key, required this.filteredList});

  @override
  State<WallpapersGrid> createState() => _WallpapersGridState();
}

class _WallpapersGridState extends State<WallpapersGrid> {
  List<Wallpaper> displayedWallpapers = [];
  final ScrollController _scrollController = ScrollController();
  int _loadedCount = 0;
  final int _loadStep = 6;

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    if (_loadedCount >= widget.filteredList.length) return;

    final nextItems = widget.filteredList
        .skip(_loadedCount)
        .take(_loadStep)
        .toList();

    setState(() {
      displayedWallpapers.addAll(nextItems);
      _loadedCount += nextItems.length;
    });
  }

  @override
  void didUpdateWidget(covariant WallpapersGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filteredList != widget.filteredList) {
      setState(() {
        displayedWallpapers = [];
        _loadedCount = 0;
      });
      _loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: displayedWallpapers.length,
      itemBuilder: (context, index) {
        final wallpaper = displayedWallpapers[index];
        return WallpaperCard(
          key: UniqueKey(), // 🔥 fuerza reinicio de animación
          wallpaper: wallpaper,
        );
      },
    );
  }
}
