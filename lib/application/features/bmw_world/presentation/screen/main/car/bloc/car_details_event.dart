part of 'car_details_bloc.dart';

@immutable
sealed class CarDetailsEvent {
  const CarDetailsEvent();

  factory CarDetailsEvent.loadCar({required int id}) => _LoadCarDetailsEvent(id);
}

class _LoadCarDetailsEvent extends CarDetailsEvent {
  final int id;

  const _LoadCarDetailsEvent(this.id);
}
