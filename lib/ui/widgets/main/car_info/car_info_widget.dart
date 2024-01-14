import 'package:bmw_world/model/_car.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:bmw_world/ui/widgets/main/car_info/car_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';

class CarInfoWidget extends StatefulWidget {
  final int carId;

  const CarInfoWidget({Key? key, required this.carId}) : super(key: key);

  @override
  State<CarInfoWidget> createState() => _CarInfoWidgetState();
}

class _CarInfoWidgetState extends State<CarInfoWidget> {
  @override
  void initState() {
    super.initState();

    Provider.of<CarInfoModel>(context, listen: false)
        .fetchCarInfo(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CarInfoModel>(context);
    final car = viewModel.car;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.blueDark,
        title: const Text('BMW'),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.hasError
              ? const Center(child: Text('Error fetching car information'))
              : car != null
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarListImageWidget(images: car.imageUri),
                            const SizedBox(height: 15),
                            _CarTitleWidget(car: car),
                            const SizedBox(height: 15),
                            _CarMainInfoWidget(car: car),
                            const SizedBox(height: 25),
                            _TabBarSection(car: car)
                          ],
                        ),
                      ],
                    )
                  : const Center(child: Text('No car information available')),
    );
  }
}

class _CarTitleWidget extends StatelessWidget {
  final Car car;
  const _CarTitleWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleTextStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BMW ${car.model} ${car.color}",
            style: titleTextStyle,
          ),
          const SizedBox(height: 2),
          Text(
            car.numberOfDoors == 2
                ? "Coupe"
                : car.numberOfDoors == 4
                    ? "Sedan"
                    : "Unknown",
            style: titleTextStyle,
          ),
        ],
      ),
    );
  }
}

class _CarMainInfoWidget extends StatelessWidget {
  final Car car;
  const _CarMainInfoWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCarMainInfoColumn(
            Icons.speed, AppColor.blue, "Max Speed", car.maxSpeed.toString()),
        _buildCarMainInfoColumn(Icons.engineering, AppColor.blueDeep, "Engine",
            car.engineSize.toString()),
        _buildCarMainInfoColumn(
            Icons.cabin, AppColor.red, "Consuption", "10.5 I"),
      ],
    );
  }

  Widget _buildCarMainInfoColumn(
      IconData iconData, Color iconColor, String text1, String text2) {
    return Column(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 40,
        ),
        Text(
          text1,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          text2,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TabBarSection extends StatefulWidget {
  final Car car;

  const _TabBarSection({Key? key, required this.car}) : super(key: key);

  @override
  State<_TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<_TabBarSection> {
  final List<String> tabTitles = ["Details", "Reviews", "Interior"];
  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    return Container(
      height: 700,
      decoration: const BoxDecoration(
        color: AppColor.blueLight,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              constraints: const BoxConstraints.expand(height: 30.0),
              child: TabBar(
                isScrollable: true,
                tabs: tabTitles
                    .map((title) => _buildTabBarTitleWidget(title))
                    .toList(),
                indicatorColor: AppColor.blueDark,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _DetailsWidget(car: car),
                  _ReviewsWidget(car: car),
                  _InteniorWidget(car: car),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildTabBarTitleWidget(String title) => Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      );
}

class _DetailsWidget extends StatelessWidget {
  final Car car;
  const _DetailsWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildDetalis(
            "Transmission type",
            car.transmission,
            "assets/auto_transmission.svg",
          ),
          _buildDetalis(
            "Body type",
            "Sedan",
            "assets/sedan_car.svg",
          ),
          _buildDetalis(
            "Maximum speed, km/h",
            car.maxSpeed.toString(),
            "assets/country.svg",
          ),
          _buildDetalis(
            "Country of assembly",
            car.countryOfAssembly,
            "assets/country.svg",
          ),
        ],
      ),
    );
  }

  Widget _buildDetalis(
    String detail,
    String value,
    String svgIconUri,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail,
              style: const TextStyle(
                color: AppColor.greyDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        SvgPicture.asset(
          svgIconUri,
          width: 35,
          height: 35,
        )
      ],
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  final Car car;
  const _ReviewsWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Tab 1 Content'),
      ],
    );
  }
}

class _InteniorWidget extends StatelessWidget {
  final Car car;
  const _InteniorWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var imageUri in car.interiorImageUri)
          _InteniorImageWidget(imageUri: imageUri),
      ],
    );
  }
}

class _InteniorImageWidget extends StatelessWidget {
  final String imageUri;
  const _InteniorImageWidget({Key? key, required this.imageUri})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InstaImageViewer(
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(imageUri),
          ),
        ),
      ),
    );
  }
}

Text _buildTabBarTitleWidget(String title) => Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );

class CarListImageWidget extends StatefulWidget {
  const CarListImageWidget({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  State<CarListImageWidget> createState() => _CarListImageWidgetState();
}

class _CarListImageWidgetState extends State<CarListImageWidget> {
  late PageController _pageController;
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void selectImage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) => _buildImageContainer(index),
            onPageChanged: (value) {
              setState(() {
                _selectedImageIndex = value;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onHorizontalDragDown: (details) {
            print("object");
          },
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _buildThumbnailContainer(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(widget.images[index]),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailContainer(int index) {
    return GestureDetector(
      onTap: () {
        selectImage(index);
        setState(() {
          _selectedImageIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedImageIndex == index
                  ? const Color(0xFF4D6DE3)
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.images[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
