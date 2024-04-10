import 'package:bmw_world/application/features/bmw_world/presentation/screen/auth/login_screen.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/setting/setting_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import '../../../../data/data_provider/token_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ProfileView()),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  void onPressedSignOut(BuildContext context) async {
    TokenProvider(sl()).deleteAccessToken();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserImage(),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserNameAndEmail(),
                  SizedBox(height: 4),
                  EditProfileButton(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Divider(),
        const SizedBox(height: 30),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const MenuButtons(),
                const SizedBox(height: 30),
                MenuButton(
                  label: "About",
                  iconData: Icons.info,
                  onPressed: () {},
                ),
                const SizedBox(height: 14),
                MenuButton(
                  label: "Sign Out",
                  iconData: Icons.logout,
                  onPressed: () => onPressedSignOut(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuButtons extends StatelessWidget {
  const MenuButtons({super.key});

  void onPressedSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingScreen()),
    );
  }

  void onPressedHelpSupport(BuildContext context) {}

  void onPressedPrivacyData(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          MenuButton(
            label: "Settings",
            iconData: Icons.settings,
            onPressed: () => onPressedSettings(context),
          ),
          MenuButton(
            label: "Help & Support",
            iconData: Icons.people,
            onPressed: () => onPressedHelpSupport(context),
          ),
          MenuButton(
            label: "Privacy and Data",
            iconData: Icons.security,
            onPressed: () => onPressedPrivacyData(context),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.label,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        iconData,
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), const Icon(Icons.arrow_forward_ios, weight: 20)],
      ),
      onPressed: onPressed,
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 70.0;
    const radius = size / 2;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius),
        image: const DecorationImage(
          image: CachedNetworkImageProvider(fakeUserImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class UserNameAndEmail extends StatelessWidget {
  const UserNameAndEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Luna Evans",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

const fakeUserImage =
    "https://img.freepik.com/free-photo/portrait-pleasant-looking-young-student-posing-against-white-wall_273609-20663.jpg?t=st=1712691378~exp=1712694978~hmac=1c215c3b5defd543f84f3e9be2ccb5863c5c0e2d95d2e3cc5bb5a41c8b33baa9&w=1800";
