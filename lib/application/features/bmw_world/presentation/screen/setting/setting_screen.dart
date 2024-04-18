import 'package:bmw_world/application/app/main_app.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Switch(
            value: themeManager.themeMode == ThemeMode.dark ||
                (themeManager.themeMode == ThemeMode.system &&
                    MediaQuery.of(context).platformBrightness == Brightness.dark),
            onChanged: (newValue) {
              themeManager.toggleTheme(newValue);
              setState(
                () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
