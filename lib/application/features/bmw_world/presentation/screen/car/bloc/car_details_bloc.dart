import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/get_car.dart';

part 'car_details_event.dart';

part 'car_details_state.dart';

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  final GetCarUseCase _getCarUseCase;

  CarDetailsBloc(this._getCarUseCase) : super(CarDetailsState.initial()) {
    on<_LoadCarDetailsEvent>(_onLoadCarDetails);
  }

  FutureOr<void> _onLoadCarDetails(
      _LoadCarDetailsEvent event, Emitter<CarDetailsState> emit) async {
    try {
      final dataState = await _getCarUseCase(params: event.id);
      dataState.when(
        success: (data) => emit(state.carLoaded(data)),
        failure: (exception) => emit(state.carError(exception)),
      );
    } catch (error) {
      emit(state.carError(error));
    }
  }
}
