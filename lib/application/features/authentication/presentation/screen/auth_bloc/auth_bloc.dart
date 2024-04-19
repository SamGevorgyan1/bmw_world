import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/authentication/data/authentication_storage_provider/authentication_provider.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationProvider _authProvider;

  AuthBloc(this._authProvider) : super(AuthState.initial()) {
    on<_AuthCheckStatusEvent>(_onAuthCheckStatusEvent);
  }

  FutureOr<void> _onAuthCheckStatusEvent(
      _AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final accessToken = await _authProvider.getAccessToken();
      if (accessToken == null) {
        emit(state.unauthorized());
      } else {
        emit(state.authorized());
      }
    } catch (error) {
      emit(state.copyWith(error: error));
    }
  }
}
