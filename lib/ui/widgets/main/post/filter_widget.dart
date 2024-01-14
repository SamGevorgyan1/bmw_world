import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:bmw_world/ui/widgets/main/post/filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildFilterContent(context);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildFilterContent(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _CarListWidget(),
      SizedBox(height: 100, child: _ColorFilterWidget()),
      Text("Year"),
      _SelectYearRangeWidget(),
      _ResultCountWidget(),
      SizedBox(height: 10),
      _ClearAllFilterButtonWidget(),
      _SelectedWidget(),
    ],
  );
}

class _ClearAllFilterButtonWidget extends StatelessWidget {
  const _ClearAllFilterButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Provider.of<FilterViewModel>(context, listen: false)
          .clearAllFilter(context),
      child: const Text("Clear All Filters"),
    );
  }
}

class _ResultCountWidget extends StatelessWidget {
  const _ResultCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resultCount = Provider.of<FilterViewModel>(context).resultCount ?? 0;

    return resultCount > 0 ? Text("Found $resultCount") : const SizedBox();
  }
}

class _SelectedWidget extends StatelessWidget {
  const _SelectedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterViewModel = Provider.of<FilterViewModel>(context);
    final model = filterViewModel.model;
    final fromYear = filterViewModel.fromYear;
    final toYear = filterViewModel.toYear ?? "2023";
    final color = filterViewModel.color;

    return (model != null || fromYear != null || color != null)
        ? GestureDetector(
            onTap: () => filterViewModel.updateParameters(context),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColor.blueDark,
                  width: 2,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model != null)
                    Text(
                      "BMW $model",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(width: 5),
                  if (color != null)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  const SizedBox(width: 3),
                  if (fromYear != null)
                    Text(
                      "Year From $fromYear to $toYear",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

class _SelectYearRangeWidget extends StatelessWidget {
  const _SelectYearRangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _SelectYearWidget(isFromYear: true),
        SizedBox(width: 50),
        _SelectYearWidget(isFromYear: false),
      ],
    );
  }
}

class _SelectYearWidget extends StatefulWidget {
  final bool isFromYear;

  const _SelectYearWidget({Key? key, required this.isFromYear})
      : super(key: key);

  @override
  State<_SelectYearWidget> createState() => _SelectYearWidgetState();
}

class _SelectYearWidgetState extends State<_SelectYearWidget> {
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    final filterViewModel = Provider.of<FilterViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          style: const TextStyle(color: Colors.black),
          value: selectedYear,
          items: List.generate(24, (index) => 2000 + index)
              .map((int year) => DropdownMenuItem<int>(
                    value: year,
                    child: Text('$year'),
                  ))
              .toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                selectedYear = newValue;
                widget.isFromYear
                    ? filterViewModel.setFromYear(newValue.toString(), context)
                    : filterViewModel.setToYear(newValue.toString(), context);
              });
            }
          },
        ),
      ],
    );
  }
}

class _ColorFilterWidget extends StatelessWidget {
  const _ColorFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterViewModel = Provider.of<FilterViewModel>(context);
    final selectedColor = filterViewModel.color;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: CarColorFilterData.getColors().length,
      itemBuilder: (context, index) {
        final colorData = CarColorFilterData.getColors()[index];
        final isSelected = colorData.color == selectedColor;

        return GestureDetector(
          onTap: () {
            filterViewModel.setColor(colorData.color);
            filterViewModel.setColorName(colorData.colorName, context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: colorData.color,
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}

class _CarListWidget extends StatelessWidget {
  const _CarListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterViewModel = Provider.of<FilterViewModel>(context);
    final cars = CarFilterData.getFakeData();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      padding: const EdgeInsets.all(0),
      itemCount: cars.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            filterViewModel.setModel(cars[index].model, context);
          },
          child: Column(
            children: [
              _CarImageWidget(imageUri: cars[index].imageUri),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cars[index].carName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _CarImageWidget extends StatelessWidget {
  final String imageUri;

  const _CarImageWidget({Key? key, required this.imageUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CarColorFilterData {
  final String colorName;
  final Color color;

  CarColorFilterData(this.colorName, this.color);

  static List<CarColorFilterData> getColors() {
    return [
      CarColorFilterData("Red", Colors.red),
      CarColorFilterData("Black", Colors.black),
      CarColorFilterData("Green", Colors.green),
      CarColorFilterData("Grey", Colors.grey),
      CarColorFilterData("Yellow", Colors.yellow),
      CarColorFilterData("White", Colors.white),
      CarColorFilterData("Purple", Colors.purple),
      CarColorFilterData("Blue", Colors.blue),
    ];
  }
}

class CarFilterData {
  final String carName;
  final String imageUri;
  final String model;

  CarFilterData(this.carName, this.model, this.imageUri);

  static List<CarFilterData> getFakeData() {
    return [
      CarFilterData("BMW X5", "X5", "assets/images/X5.png"),
      CarFilterData("BMW X6", "X6", "assets/images/X6.png"),
      CarFilterData("BMW M4", "M4", "assets/images/M4.png"),
      CarFilterData("BMW M5", "M5", "assets/images/M5.png"),
      CarFilterData("BMW M8", "M8", "assets/images/M8.png"),
    ];
  }
}
