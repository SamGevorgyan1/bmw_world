import 'package:json_annotation/json_annotation.dart';

part '_car.g.dart';

@JsonSerializable()
class Car {
  final int carId;

  final String name;
  final String model;
  final List<String> imageUri;
  final List<String> interiorImageUri;

  final int year;
  final String color;
  final String fuelType;
  final int numberOfDoors;
  final String transmission;
  final int maxSpeed;
  final double engineSize;
  final int horsePower;
  final String countryOfAssembly;

  Car(
    this.carId,
    this.name,
    this.model,
    this.year,
    this.color,
    this.fuelType,
    this.numberOfDoors,
    this.transmission,
    this.maxSpeed,
    this.engineSize,
    this.horsePower,
    this.countryOfAssembly,
    this.imageUri,
    this.interiorImageUri,
  );
  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);
}
