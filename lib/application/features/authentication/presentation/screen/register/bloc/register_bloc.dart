import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/data/dto/register_request.dart';
import 'package:meta/meta.dart';
import '../../../../domain/repository/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc(this._authRepository) : super(RegisterState.initial()) {
    on<_RegisterButtonPressedEvent>(_onRegisterButtonPressed);
    on<_VerifyUserEvent>(_onVerifyUserEvent);
    on<_SendVerificationCode>(_onSendVerificationCodeEvent);

  }

  Future<void> _onRegisterButtonPressed(
    _RegisterButtonPressedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.loading());
      final registerRequest = RegisterRequest(
          firstname: event.firstName,
          lastname: event.lastName,
          email: event.email,
          password: event.password);
      final dataState = await _authRepository.register(registerRequest);
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
        final dataState = await _authRepository.verify(state.email!, event.verifyCode);
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
        final dataState = await _authRepository.sendVerificationCode(state.email!);
        dataState.when(
          success: (_) => emit(state.enableVerification()),
          failure: (exception) => emit(state.verifyErrorState(exception)),
        );
      }
    } catch (error) {
      emit(state.verifyErrorState(error));
    }
  }
}
