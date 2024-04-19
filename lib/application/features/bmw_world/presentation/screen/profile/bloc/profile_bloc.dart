import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/domain/model/user.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_user.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase _userUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileBloc(this._userUseCase, this._logoutUseCase) : super(ProfileState.initial()) {
    on<_GetUserEvent>(_onGetUser);
    on<_LogoutEvent>(_onLogout);
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

  FutureOr<void> _onLogout(_LogoutEvent event, Emitter<ProfileState> emit) async {
    try {
      final dataState = await _logoutUseCase();
      dataState.when(
        success: (_) => emit(state.logoutSuccess()),
        failure: (error) => emit(state.logoutErrorState(error)),
      );
    } catch (error) {
      emit(state.logoutErrorState(error));
    }
  }
}
