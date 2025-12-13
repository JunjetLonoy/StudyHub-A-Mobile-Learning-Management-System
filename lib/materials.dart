import 'package:flutter/material.dart';
import 'addmaterial.dart';
import 'theme_provider.dart';

class MaterialsPage extends StatefulWidget {
  final List<Map<String, dynamic>> materials;
  final Function(int) onToggleFavorite;
  final Function(Map<String, dynamic>) onAddMaterial;
  final bool favoriteEnabled;

  const MaterialsPage({
    Key? key,
    required this.materials,
    required this.onToggleFavorite,
    required this.onAddMaterial,
    required this.favoriteEnabled,
  }) : super(key: key);

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMaterials {
    if (_searchQuery.isEmpty) {
      return widget.materials;
    }
    return widget.materials.where((material) {
      final title = material['title'].toString().toLowerCase();
      final category = material['category'].toString().toLowerCase();
      return title.contains(_searchQuery) || category.contains(_searchQuery);
    }).toList();
  }

  void _openMaterial(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${widget.materials[index]['title']}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _addMaterial() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMaterialPage()),
    );

    if (result != null) {
      widget.onAddMaterial(result);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Material added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFE8E9F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Materials',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Access your learning resources',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search materials...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: isDarkMode ? Colors.white70 : Colors.black38),
                      ),
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredMaterials.length,
                itemBuilder: (context, index) {
                  final material = _filteredMaterials[index];
                  final originalIndex = widget.materials.indexOf(material);
                  return _buildMaterialCard(
                    title: material['title'],
                    category: material['category'],
                    size: material['size'],
                    color: material['color'],
                    icon: material['icon'],
                    isFavorite: material['isFavorite'],
                    onFavoriteToggle: () => widget.onToggleFavorite(originalIndex),
                    onOpen: () => _openMaterial(originalIndex),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMaterial,
        backgroundColor: const Color(0xFF9333EA),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMaterialCard({
    required String title,
    required String category,
    required String size,
    required Color color,
    required IconData icon,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
    required VoidCallback onOpen,
  }) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9D5FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9333EA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      size,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          IconButton(
            onPressed: onFavoriteToggle,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : (isDarkMode ? Colors.white70 : Colors.black38),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onOpen,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE9D5FF),
              foregroundColor: const Color(0xFF9333EA),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Open',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}