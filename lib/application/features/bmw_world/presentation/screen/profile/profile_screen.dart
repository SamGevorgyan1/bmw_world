import 'package:bmw_world/application/features/authentication/presentation/screen/auth_screen.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/profile/bloc/profile_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/setting/setting_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../di/injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(ProfileEvent.getUser()),
      child: const Scaffold(
        body: Center(
          child: ProfileView(),
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  void onPressedSignOut(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileEvent.logout());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isLogoutSuccess!) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false,
          );
        }
      },
      child: Column(
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
                    label: S().about,
                    iconData: Icons.info,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 14),
                  MenuButton(
                    label: S().signOut,
                    iconData: Icons.logout,
                    onPressed: () => onPressedSignOut(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            label: S().settings,
            iconData: Icons.settings,
            onPressed: () => onPressedSettings(context),
          ),
          MenuButton(
            label: S().helpSupport,
            iconData: Icons.people,
            onPressed: () => onPressedHelpSupport(context),
          ),
          MenuButton(
            label: S().privacyData,
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                state.imageUrl ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class UserNameAndEmail extends StatelessWidget {
  const UserNameAndEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final userNameAndSurname = "${state.firstName} ${state.lastName}";
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userNameAndSurname, style: Theme.of(context).textTheme.headlineLarge),
          ],
        );
      },
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
        child: Text(S().editProfile),
      ),
    );
  }
}
