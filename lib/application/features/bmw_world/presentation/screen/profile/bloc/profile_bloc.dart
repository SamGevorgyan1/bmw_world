import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/data/model/user.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_user.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase _userUseCase;

  ProfileBloc(this._userUseCase) : super(ProfileState.initial()) {
    on<_GetUserEvent>(_onGetUser);
  }

  FutureOr<void> _onGetUser(_GetUserEvent event, Emitter emit) async {
    emit(state.loading());
    try {
      final user = await _userUseCase();
      if (user != null) {
        emit(state.userLoaded(user: user));
      } else {
        emit(state.profileErrorState(Exception()));
      }
    } catch (error) {
      emit(state.profileErrorState(error));
    }
  }
}
