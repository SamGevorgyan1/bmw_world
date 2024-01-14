import 'package:bmw_world/domain/api_client/auth_api.dart';
import 'package:bmw_world/domain/data_provider/session_data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLoginEvent({
    required this.login,
    required this.password,
  });
}

abstract class AuthState {}

class AuthUnauthorizedState extends AuthState {}

class AuthAuthorizedState extends AuthState {}

class AuthFailureState extends AuthState {
  final Object error;
  AuthFailureState(this.error);
}

class AuthInProgressState extends AuthState {}

class AuthCheckStatusInProgressState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authApiClient = AuthApiClient();

  final _sessionDataProvider = SessionDataProvider();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    });
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgressState());
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
        sessionId != null ? AuthAuthorizedState() : AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthInProgressState());
      final loginResponse = await _authApiClient.login(
        event.login,
        event.password,
      );
      final String sessionId = loginResponse.sessionId;
      final String token = loginResponse.authToken;
      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setToken(token);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      await _sessionDataProvider.deleteToken();
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}