import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: AppColor.blueDark),
        ),
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Favorites",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
