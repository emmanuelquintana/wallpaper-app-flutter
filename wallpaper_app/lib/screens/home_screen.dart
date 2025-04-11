import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/featured_slider.dart';
import '../widgets/category_chip.dart';
import '../widgets/wallpapers_grid.dart';
import '../models/wallpaper.dart';
import '../data/wallpapers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'Todos';
  String selectedOrder = 'Fecha reciente';
  List<Wallpaper> filteredWallpapers = [];

  final categories = [
    'Todos',
    'Naturaleza',
    'Espacio',
    'Anime',
    'Abstracto',
    'Arquitectura',
  ];
  final orderOptions = [
    'Fecha reciente',
    'Más likes',
    'Más descargas',
    'Aleatorio',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _applyFilters();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    List<Wallpaper> result = wallpapers.where((wallpaper) {
      final matchesText =
          wallpaper.title.toLowerCase().contains(query) ||
          wallpaper.category.toLowerCase().contains(query);
      final matchesCategory =
          selectedCategory == 'Todos' ||
          wallpaper.category == selectedCategory;
      return matchesText && matchesCategory;
    }).toList();

    switch (selectedOrder) {
      case 'Más likes':
        result.sort((a, b) => b.likes.compareTo(a.likes));
        break;
      case 'Más descargas':
        result.sort((a, b) => b.downloads.compareTo(a.downloads));
        break;
      case 'Aleatorio':
        result.shuffle();
        break;
      case 'Fecha reciente':
      default:
        break;
    }

    setState(() {
      filteredWallpapers = result;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.azulNoche1,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.azulNoche2),
              child: Text('Menú', style: TextStyle(color: AppColors.blanco)),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: AppColors.blanco),
              title: const Text('Mis me gusta', style: TextStyle(color: AppColors.blanco)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/me-gusta');
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: AppColors.blanco),
              title: const Text('Mis descargas', style: TextStyle(color: AppColors.blanco)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/descargas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.blanco),
              title: const Text('Perfil', style: TextStyle(color: AppColors.blanco)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/perfil');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: AppColors.blanco),
          decoration: const InputDecoration(
            hintText: 'Buscar fondos...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: FeaturedSlider()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categorías populares',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedOrder,
                    isDense: true,
                    underline: const SizedBox(),
                    iconEnabledColor: Colors.white,
                    dropdownColor: AppColors.azulNoche2,
                    style: const TextStyle(color: Colors.white),
                    items: orderOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null && value != selectedOrder) {
                        setState(() {
                          selectedOrder = value;
                        });
                        Future.delayed(Duration.zero, _applyFilters);
                      }
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  spacing: 12,
                  children: categories.map((cat) {
                    return CategoryChip(
                      label: cat,
                      selected: cat == selectedCategory,
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                        });
                        _applyFilters();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: WallpapersGrid(filteredList: filteredWallpapers),
            ),
          ],
        ),
      ),
    );
  }
}
