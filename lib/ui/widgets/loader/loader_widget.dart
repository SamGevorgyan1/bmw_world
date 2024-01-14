import 'package:bmw_world/ui/navigation/main_navigation.dart';
import 'package:bmw_world/ui/widgets/loader/loader_view_cibit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: onLoaderViewCubitStateChange,
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void onLoaderViewCubitStateChange(
    BuildContext context,
    LoaderViewCubitState state,
  ) {
    final nextScreen = state == LoaderViewCubitState.authorized
        ? MainNavigationRouteNames.mainWidget
        : MainNavigationRouteNames.authWidget;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
