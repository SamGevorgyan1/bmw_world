import 'package:bmw_world/application/features/bmw_world/presentation/screen/article/article_screen.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/post/post_screen.dart';
import 'package:bmw_world/resources/resources.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/custom_theme/color_theme.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = const [
    ArticleScreen(),
    PostScreen(),
    ProfileScreen(),
  ];

  void onTap(int index) {
    if (index >= 0 && index < pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article_rounded),
          ),
          BottomNavigationBarItem(
            label: '',
            // icon: Icon(Icons.article_outlined),
            // activeIcon: Icon(Icons.article_rounded),
            icon: Image.asset(
              AppImages.icBmw,
              color: colorSchemeDark.secondary,
            ),
            activeIcon: Image.asset(AppImages.icBmwActive),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
        ],
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedFontSize: 8,
        iconSize: 28,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
