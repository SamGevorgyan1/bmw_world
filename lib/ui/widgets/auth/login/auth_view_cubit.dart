import 'dart:async';

import 'package:bmw_world/domain/bloc/auth_bloc.dart';
import 'package:bmw_world/exception/api_client_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthViewCubitState {}

class AuthViewCubitFormFillInProgressState extends AuthViewCubitState {}

class AuthViewCubitErrorState extends AuthViewCubitState {
  final String errorMessage;

  AuthViewCubitErrorState(this.errorMessage);
}

class AuthViewCubitAuthProgressState extends AuthViewCubitState {}

class AuthViewCubitSuccessAuthState extends AuthViewCubitState {}

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(
    AuthViewCubitState initialState,
    this.authBloc,
  ) : super(initialState) {
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  void auth({required String login, required String password}) {
    if (!_isValid(login, password)) {
      final state = AuthViewCubitErrorState('Fill in your login and password');
      emit(state);
      return;
    }
    authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(AuthViewCubitFormFillInProgressState());
    } else if (state is AuthAuthorizedState) {
      authBlocSubscription.cancel();
      emit(AuthViewCubitSuccessAuthState());
    } else if (state is AuthFailureState) {
      final message = _mapErrorToMessage(state.error);
      emit(AuthViewCubitErrorState(message));
    } else if (state is AuthInProgressState) {
      emit(AuthViewCubitAuthProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(AuthViewCubitAuthProgressState());
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiClientException) {
      return 'Unknown error, please try again';
    }
    switch (error.type) {
      case ApiClientExceptionType.network:
        return 'Server is not available. Check your internet connection';
      case ApiClientExceptionType.auth:
        return 'Incorrect login password!';
      case ApiClientExceptionType.sessionExpired:
      case ApiClientExceptionType.other:
        return 'An error has occurred. try again';
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
