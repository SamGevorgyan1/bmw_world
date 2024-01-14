import 'package:bmw_world/domain/data_provider/session_data_provider.dart';
import 'package:bmw_world/ui/navigation/main_navigation.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColor.blueDark),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            Column(
              children: [
                SizedBox(height: 20),
                _UserInfoWidget(),
                SizedBox(height: 20),
                _MenuWidget(),
              ],
            ),
          ],
        ));
  }
}

class _MenuWidget extends StatelessWidget {
  const _MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressedSetting() {
      Navigator.of(context).pushNamed(MainNavigationRouteNames.settingWidget);
    }

    void onPressedFavorite() {
      Navigator.of(context).pushNamed(MainNavigationRouteNames.favoriteWidget);
    }

    void onPressedChangePassword() {
      Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.changePasswordWidget);
    }

    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          _menuButton("Data", Icons.person, () {}),
          _menuButton("Settings", Icons.settings, onPressedSetting),
          _menuButton("Information", Icons.info, () {}),
          _menuButton("Favorites", Icons.favorite, onPressedFavorite),
          const SizedBox(height: 20),
          _menuButton("Change Password", Icons.lock, onPressedChangePassword),
          _menuButton("Log out", Icons.logout, () {
            final SessionDataProvider sessionDataProvider =
                SessionDataProvider();
            sessionDataProvider.deleteSessionId();
            sessionDataProvider.deleteSessionId();
            Navigator.pushNamedAndRemoveUntil(
                context,
                MainNavigationRouteNames.loaderWidget,
                (Route<dynamic> route) => false);
            print("Login button clicked");
          }),
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/M5.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String name, IconData iconData, VoidCallback onPressed) {
    return _MenuButtonWidget(
      name: name,
      iconData: iconData,
      onPressed: onPressed,
    );
  }
}

class _MenuButtonWidget extends StatelessWidget {
  final String name;
  final IconData iconData;
  final VoidCallback onPressed;
  const _MenuButtonWidget(
      {Key? key,
      required this.name,
      required this.iconData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconSize = 25.0;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  size: iconSize,
                  color: AppColor.blueDark,
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColor.greyDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, size: iconSize),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Divider(
                height: 3,
                color: AppColor.greyDark,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  const _UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UserImageWidget(onPressed: () {}),
        const SizedBox(height: 10),
        const _UserFullNameWidget(),
        const SizedBox(height: 5),
        const _UserEmailWidget(),
      ],
    );
  }
}

class _UserFullNameWidget extends StatelessWidget {
  const _UserFullNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Emma Quinn",
      style: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _UserEmailWidget extends StatelessWidget {
  const _UserEmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "emma.quinn@gmail.com",
      style: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _UserImageWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const _UserImageWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipOval(
        child: Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(65),
            image: const DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-photo/young-brunette-woman-standing-blue-background-smiling-looking-camera-showing-fingers-doing-victory-sign-number-two_839833-32541.jpg?w=1800&t=st=1700251222~exp=1700251822~hmac=cadfdffac2a391e64c722110044547be981c1723f96e6af3517c1d96928481d6"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
