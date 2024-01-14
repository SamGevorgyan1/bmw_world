import 'package:bmw_world/domain/factories/screen_factory.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late ScreenFactory _screenFactory;

  _MainWidgetState() {
    _screenFactory = ScreenFactory();
  }

  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _screenFactory.makeArticleWidget(),
      _screenFactory.makePostWidget(),
      _screenFactory.makeNotificationWidget(),
      _screenFactory.makeProfileWidget(),
    ];
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Articles",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash),
            label: "Models",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        backgroundColor: AppColor.background,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
