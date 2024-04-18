import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSize {
  const CustomAppBarWidget({
    Key?key,
    required this.title,
    required this.callback,
    required this.buttonTitle,
  }):super(key: key);

  final String title;
  final VoidCallback callback;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed:callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            buttonTitle,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
