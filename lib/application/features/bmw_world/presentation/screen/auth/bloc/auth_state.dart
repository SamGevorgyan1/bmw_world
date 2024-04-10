part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthUnauthorizedState extends AuthState {
  const AuthUnauthorizedState();
}

class AuthAuthorizedState extends AuthState {
  const AuthAuthorizedState();
}

class AuthFailureState extends AuthState {
  final Object exception;

  const AuthFailureState(this.exception);
}

class AuthInProgressState extends AuthState {
  const AuthInProgressState();
}

class AuthCheckStatusInProgressState extends AuthState {
  const AuthCheckStatusInProgressState();
}
