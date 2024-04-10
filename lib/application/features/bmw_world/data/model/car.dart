import 'package:bmw_world/application/features/bmw_world/domain/entities/car_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class CarModel extends CarEntity {
  final int? id;
  final String? name;
  final String? model;
  final List<String>? imageUrls;
  final List<String>? interiorImageUrls;
  final int? year;
  final String? color;
  final String? fuelType;
  final int? numberOfDoors;
  final String? transmission;
  final int? maxSpeed;
  final double? engineSize;
  final int? horsePower;
  final String? countryOfAssembly;

  const CarModel(
    this.id,
    this.name,
    this.model,
    this.imageUrls,
    this.interiorImageUrls,
    this.year,
    this.color,
    this.fuelType,
    this.numberOfDoors,
    this.transmission,
    this.maxSpeed,
    this.engineSize,
    this.horsePower,
    this.countryOfAssembly,
  );

  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
}
