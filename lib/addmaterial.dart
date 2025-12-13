import 'package:flutter/material.dart';

class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({Key? key}) : super(key: key);

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _sizeController = TextEditingController();
  final _notesController = TextEditingController();
  String? selectedFile;
  
  String selectedCategory = 'data mining';
  Color selectedColor = const Color(0xFF9333EA);
  IconData selectedIcon = Icons.description;

  final List<String> categories = [
    'data mining',
    'data analysis',
    'machine learning',
    'programming',
    'other',
  ];

  final List<Map<String, dynamic>> colorOptions = [
    {'color': const Color(0xFFEF4444), 'name': 'Red'},
    {'color': const Color(0xFFF59E0B), 'name': 'Orange'},
    {'color': const Color(0xFF84CC16), 'name': 'Green'},
    {'color': const Color(0xFF3B82F6), 'name': 'Blue'},
    {'color': const Color(0xFF9333EA), 'name': 'Purple'},
    {'color': const Color(0xFFEC4899), 'name': 'Pink'},
  ];

  final List<Map<String, dynamic>> iconOptions = [
    {'icon': Icons.description, 'name': 'Document'},
    {'icon': Icons.book, 'name': 'Book'},
    {'icon': Icons.science, 'name': 'Lab'},
    {'icon': Icons.code, 'name': 'Code'},
    {'icon': Icons.video_library, 'name': 'Video'},
    {'icon': Icons.article, 'name': 'Article'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _saveMaterial() {
    if (_formKey.currentState!.validate()) {
      final newMaterial = {
        'title': _titleController.text,
        'category': selectedCategory,
        'size': '${_sizeController.text} mb',
        'color': selectedColor,
        'icon': selectedIcon,
        'isFavorite': false,
        'notes': _notesController.text,
        'file': selectedFile,
      };

      Navigator.pop(context, newMaterial);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Material',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              const Text(
                'Material Title',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter material title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Category Selection
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Size Input
              const Text(
                'File Size (MB)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sizeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter file size',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter file size';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Notes Input
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter notes about the material',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // File Upload
              const Text(
                'Upload File',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Simulate file selection
                        setState(() {
                          selectedFile = 'selected_file.pdf'; // Placeholder
                        });
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Select File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9333EA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (selectedFile != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Selected: $selectedFile',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Color Selection
              const Text(
                'Color',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: colorOptions.map((colorOption) {
                  final color = colorOption['color'] as Color;
                  final isSelected = selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.black87 : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Icon Selection
              const Text(
                'Icon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: iconOptions.map((iconOption) {
                  final icon = iconOption['icon'] as IconData;
                  final isSelected = selectedIcon == icon;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF9333EA)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF9333EA)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? Colors.white : Colors.black54,
                        size: 28,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _saveMaterial,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9333EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add Material',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}