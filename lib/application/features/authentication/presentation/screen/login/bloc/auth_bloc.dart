import 'package:bmw_world/application/features/authentication/data/data_provider/user_provider.dart';
import 'package:bmw_world/application/features/authentication/data/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../data/data_provider/token_provider.dart';
import '../../../../domain/repository/auth_repository.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final TokenProvider _tokenProvider;
  final UserProvider _userProvider;

  AuthBloc(
    this._authRepository,
    this._tokenProvider,
    this._userProvider,
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

    dataState.when(
      success: (data) {
        _setAccessToken(data.accessToken!);
        _setUser(data.accessToken!);
        emit(const AuthAuthorizedState());
      },
      failure: (exception) => emit(AuthFailureState(dataState.exception)),
    );
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _tokenProvider.deleteAccessToken();
      await _userProvider.deleteUser();
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> _setAccessToken(String accessToken) async {
    await _tokenProvider.setAccessToken(accessToken);
  }

  Future<void> _setUser(String accessToken) async {
    final decodedToken = JwtDecoder.decode(accessToken);
    print(decodedToken["firstname"]);


    await _userProvider.setUser(User.fromJson(decodedToken));
  }
}
