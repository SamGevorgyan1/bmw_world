part of 'car_details_bloc.dart';

@immutable
class CarDetailsState {
  final CarModel? car;
  final Object? error;
  final bool isLoading;

  const CarDetailsState({this.car, this.error, this.isLoading = false});

  CarDetailsState copyWith({
    CarModel? car,
    Object? error,
    bool? isLoading,
  }) {
    return CarDetailsState(
      car: car ?? this.car,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory CarDetailsState.initial() => const CarDetailsState(isLoading: true);

  CarDetailsState carLoaded(CarModel car) {
    return copyWith(car: car, isLoading: false);
  }

  CarDetailsState carError(Object error) {
    return copyWith(error: error, isLoading: false);
  }
}
