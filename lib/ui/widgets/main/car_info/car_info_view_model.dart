import 'package:bmw_world/domain/repository/car_repository.dart';
import 'package:bmw_world/model/_car.dart';
import 'package:flutter/material.dart';

class CarInfoModel extends ChangeNotifier {
  final CarRepository _carRepository = CarRepository();
  Car? _car;
  bool _isLoading = false;
  bool _hasError = false;
  bool isDataLoaded = false;

  Car? get car => _car;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchCarInfo(int carId) async {
    _isLoading = true;
    _hasError = false;

    try {
      _car = await _carRepository.getCarById(carId);
      isDataLoaded = true;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
