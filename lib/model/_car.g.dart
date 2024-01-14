// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      json['carId'] as int,
      json['name'] as String,
      json['model'] as String,
      json['year'] as int,
      json['color'] as String,
      json['fuelType'] as String,
      json['numberOfDoors'] as int,
      json['transmission'] as String,
      json['maxSpeed'] as int,
      (json['engineSize'] as num).toDouble(),
      json['horsePower'] as int,
      json['countryOfAssembly'] as String,
      (json['imageUri'] as List<dynamic>).map((e) => e as String).toList(),
      (json['interiorImageUri'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'carId': instance.carId,
      'name': instance.name,
      'model': instance.model,
      'imageUri': instance.imageUri,
      'interiorImageUri': instance.interiorImageUri,
      'year': instance.year,
      'color': instance.color,
      'fuelType': instance.fuelType,
      'numberOfDoors': instance.numberOfDoors,
      'transmission': instance.transmission,
      'maxSpeed': instance.maxSpeed,
      'engineSize': instance.engineSize,
      'horsePower': instance.horsePower,
      'countryOfAssembly': instance.countryOfAssembly,
    };
