import 'package:bmw_world/application/features/bmw_world/presentation/screen/car/bloc/car_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../di/injection_container.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({Key? key, required this.carId}) : super(key: key);
  final int carId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarDetailsBloc>(
      create: (context) => sl<CarDetailsBloc>()..add(CarDetailsEvent.loadCar(id: carId)),
      child: BlocBuilder<CarDetailsBloc, CarDetailsState>(
        builder: (BuildContext context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            // TODO
            return Center(child: Text(state.error.toString()));
          }
          if (state.car != null) {
            return const CarDetailsView();
          }
          // TODO
          return const Center(child: Text('Car not available'));
        },
      ),
    );
  }
}

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarImages(),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CarName(),
          ),
          SizedBox(height: 10),
          CarMainInfo(),
          CarCharacteristic(),
        ],
      ),
    );
  }
}

class CarCharacteristic extends StatelessWidget {
  const CarCharacteristic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CarImages extends StatelessWidget {
  const CarImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDetailsBloc, CarDetailsState>(
      builder: (context, state) {
        final carDetails = state.car;
        final images = carDetails?.imageUrls;
        return GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
              itemCount: images?.length,
              onPageChanged: (index) {},
              //scrollPhysics: const BouncingScrollPhysics(),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  initialScale: PhotoViewComputedScale.contained,
                  imageProvider: CachedNetworkImageProvider(
                    images?[index] ?? "",
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CarMainInfo extends StatelessWidget {
  const CarMainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDetailsBloc, CarDetailsState>(
      builder: (context, state) {
        final carDetails = state.car;
        final maxSpeed = carDetails?.maxSpeed.toString() ?? "";
        final engineSize = carDetails?.engineSize.toString() ?? "";
        final consumption = carDetails?.fuelType ?? "";
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildColumn(context, Icons.speed, S().maxSpeed, "$maxSpeed km/h", Colors.blue),
            _buildColumn(
                context, Icons.engineering_outlined, S().engine, engineSize, Colors.blueAccent),
            _buildColumn(context, Icons.oil_barrel, S().consumption, consumption, Colors.redAccent),
          ],
        );
      },
    );
  }

  Column _buildColumn(
      BuildContext context, IconData iconData, String title, String details, Color iconColor) {
    return Column(
      children: [
        Icon(iconData, color: iconColor, size: 34),
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        Text(details, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class CarName extends StatelessWidget {
  const CarName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDetailsBloc, CarDetailsState>(
      builder: (context, state) {
        final car = state.car;
        final name = car?.name ?? "";
        final color = car?.color ?? "";
        final model = car?.model ?? "";
        return Text(
          "$name $model $color",
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineLarge,
        );
      },
    );
  }
}
