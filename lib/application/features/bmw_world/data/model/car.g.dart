// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      json['id'] as int?,
      json['name'] as String?,
      json['model'] as String?,
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['interiorImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['year'] as int?,
      json['color'] as String?,
      json['fuelType'] as String?,
      json['numberOfDoors'] as int?,
      json['transmission'] as String?,
      json['maxSpeed'] as int?,
      (json['engineSize'] as num?)?.toDouble(),
      json['horsePower'] as int?,
      json['countryOfAssembly'] as String?,
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'imageUrls': instance.imageUrls,
      'interiorImageUrls': instance.interiorImageUrls,
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
