import 'dart:io';

import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/car_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/car_repository.dart';
import 'package:dio/dio.dart';


class CarRepositoryImpl implements CarRepository {
  final CarApiService _carApiService;

  const CarRepositoryImpl(this._carApiService);

  @override
  Future<DataState<CarModel>> get(int id) async {
    try {
      final httpResponse = await _carApiService.get(id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}