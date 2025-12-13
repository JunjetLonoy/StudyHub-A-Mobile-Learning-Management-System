import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const ThemeProvider({
    super.key,
    required super.child,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}

class ThemeProviderWidget extends StatefulWidget {
  final Widget child;

  const ThemeProviderWidget({super.key, required this.child});

  @override
  ThemeProviderState createState() => ThemeProviderState();
}

class ThemeProviderState extends State<ThemeProviderWidget> {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkMode: _isDarkMode,
      toggleDarkMode: toggleDarkMode,
      child: widget.child,
    );
  }
}
