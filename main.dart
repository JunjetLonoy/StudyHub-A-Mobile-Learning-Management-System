import 'package:flutter/material.dart';
import 'home.dart';
import 'materials.dart';
import 'progress.dart';
import 'profile.dart';
import 'theme_provider.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProviderWidget(
      child: const MaterialAppWrapper(),
    );
  }
}

class MaterialAppWrapper extends StatefulWidget {
  const MaterialAppWrapper({Key? key}) : super(key: key);

  @override
  State<MaterialAppWrapper> createState() => _MaterialAppWrapperState();
}

class _MaterialAppWrapperState extends State<MaterialAppWrapper> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider.isDarkMode;
    return MaterialApp(
      title: 'Learning App',
      theme: isDarkMode ? ThemeData.dark() : ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFE8E9F3),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool favoriteEnabled = false;

  final List<Map<String, dynamic>> materials = [
    {
      'title': 'Cluster Notes',
      'category': 'data mining',
      'size': '2.8 mb',
      'color': const Color(0xFFEF4444),
      'icon': Icons.description,
      'isFavorite': false,
    },
    {
      'title': 'Task #3',
      'category': 'data mining',
      'size': '4.5 mb',
      'color': const Color(0xFFF59E0B),
      'icon': Icons.book,
      'isFavorite': false,
    },
    {
      'title': 'Data Mining Lab',
      'category': 'data mining',
      'size': '6.9 mb',
      'color': const Color(0xFF84CC16),
      'icon': Icons.science,
      'isFavorite': false,
    },
    {
      'title': 'Task #2',
      'category': 'data analysis',
      'size': '10.5 mb',
      'color': const Color(0xFF3B82F6),
      'icon': Icons.book,
      'isFavorite': false,
    },
    {
      'title': 'Data Analysis Lab',
      'category': 'data analysis',
      'size': '5.8 mb',
      'color': const Color(0xFFEC4899),
      'icon': Icons.science,
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      materials[index]['isFavorite'] = !materials[index]['isFavorite'];
    });
  }

  void _addMaterial(Map<String, dynamic> newMaterial) {
    setState(() {
      materials.add(newMaterial);
    });
  }

  void _toggleFavoriteEnabled(bool value) {
    setState(() {
      favoriteEnabled = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider.isDarkMode;

    final List<Widget> _pages = [
      const HomePage(),
      MaterialsPage(
        materials: materials,
        onToggleFavorite: _toggleFavorite,
        onAddMaterial: _addMaterial,
        favoriteEnabled: favoriteEnabled,
      ),
      const ProgressPage(),
      ProfilePage(
        favoriteEnabled: favoriteEnabled,
        onToggleFavoriteEnabled: _toggleFavoriteEnabled,
      ),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            selectedItemColor: const Color(0xFF9333EA),
            unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black38,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                activeIcon: Icon(Icons.book),
                label: 'Materials',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                activeIcon: Icon(Icons.bar_chart),
                label: 'Progress',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}