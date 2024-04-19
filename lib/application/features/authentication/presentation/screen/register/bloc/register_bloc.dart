import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/login_request.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/register_request.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/login_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/registration_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/send_verify_code_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/verify_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/value_object/verify_params.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegistrationUseCase _registerUseCase;
  final SendVerifyCodeUseCase _sendVerifyCodeUseCase;
  final VerifyUseCase _verifyUseCase;
  final LoginUseCase _loginUseCase;

  RegisterBloc(
    this._registerUseCase,
    this._sendVerifyCodeUseCase,
    this._verifyUseCase,
    this._loginUseCase,
  ) : super(RegisterState.initial()) {
    on<_RegisterButtonPressedEvent>(_onRegisterButtonPressed);
    on<_VerifyUserEvent>(_onVerifyUserEvent);
    on<_SendVerificationCode>(_onSendVerificationCodeEvent);
    on<_LoginEvent>(_onLoginEvent);
  }

  Future<void> _onRegisterButtonPressed(
    _RegisterButtonPressedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.loading());
      final registerRequest = RegisterRequest(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password);
      final dataState = await _registerUseCase(params: registerRequest);
      dataState.when(
        success: (_) => emit(state.registrationSuccess(event.email, event.password)),
        failure: (exception) => emit(state.registrationErrorState(exception)),
      );
    } catch (error) {
      emit(state.registrationErrorState(error));
    }
  }

  Future<void> _onVerifyUserEvent(
    _VerifyUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      if (state.email != null) {
        final verifyParams = VerifyParams(email: state.email!, verificationCode: event.verifyCode);
        final dataState = await _verifyUseCase(params: verifyParams);
        dataState.when(
          success: (_) => emit(state.verificationSuccess()),
          failure: (exception) => emit(state.verifyErrorState(exception)),
        );
      }
    } catch (error) {
      emit(state.verifyErrorState(error));
    }
  }

  FutureOr<void> _onSendVerificationCodeEvent(_SendVerificationCode event, Emitter emit) async {
    try {
      if (state.isRegistrationSuccess ?? false) {
        final dataState = await _sendVerifyCodeUseCase(params: state.email!);
        dataState.when(
          success: (_) => emit(state.enableVerification()),
          failure: (exception) => emit(state.verifyErrorState(exception)),
        );
      }
    } catch (error) {
      emit(state.verifyErrorState(error));
    }
  }

  FutureOr<void> _onLoginEvent(_LoginEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(isLoginLoading: true));
      final dataState =
          await _loginUseCase(params: LoginRequest(email: state.email!, password: state.password!));

      dataState.when(
        success: (_) => emit(state.loginSuccess()),
        failure: (error) => emit(state.loginErrorState(error)),
      );
    } catch (error) {
      emit(state.loginErrorState(error));
    }
  }
}
