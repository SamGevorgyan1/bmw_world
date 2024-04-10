import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
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

  const CarEntity({
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
  });

  @override
  List<Object?> get props => [
        name,
        model,
        imageUrls,
        interiorImageUrls,
        year,
        color,
        fuelType,
        numberOfDoors,
        transmission,
        maxSpeed,
        engineSize,
        horsePower,
        countryOfAssembly,
      ];
}
