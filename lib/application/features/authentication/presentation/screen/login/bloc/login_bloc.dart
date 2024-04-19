import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/login_request.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/login_usecase.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginState.initial()) {
    on<_LoginWithEmailPassword>(_onLoginWithEmailPassword);
  }

  FutureOr<void> _onLoginWithEmailPassword(
      _LoginWithEmailPassword event, Emitter<LoginState> emit) async {
    try {
      final dataState =
          await _loginUseCase(params: LoginRequest(email: event.email, password: event.password));
      dataState.when(
        success: (_) => emit(state.loginSuccess()),
        failure: (error) => emit(state.loginErrorState(error)),
      );
    } catch (error) {
      emit(state.loginErrorState(error));
    }
  }

}
