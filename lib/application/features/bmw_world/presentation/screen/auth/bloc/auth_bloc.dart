import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state/data_state.dart';
import '../../../../data/data_provider/token_provider.dart';
import '../../../../domain/repository/auth_repository.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final TokenProvider _tokenProvider;
  AuthBloc(
    this._authRepository,
    this._tokenProvider,
  ) : super(const AuthUnauthorizedState()) {
    on<AuthCheckStatusEvent>(onAuthCheckStatusEvent);
    on<AuthLoginEvent>(onAuthLoginEvent);
    on<AuthLogoutEvent>(onAuthLogoutEvent);
    add(const AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInProgressState());
    final accessToken = await _tokenProvider.getAccessToken();
    final newState =
        accessToken != null ? const AuthAuthorizedState() : const AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInProgressState());
    final dataState = await _authRepository.login(
      event.login,
      event.password,
    );
    if (dataState is DataSuccess) {
      final String accessToken = dataState.data!.accessToken!;
      await _tokenProvider.setAccessToken(accessToken);
      emit(const AuthAuthorizedState());
    }
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _tokenProvider.deleteAccessToken();
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
