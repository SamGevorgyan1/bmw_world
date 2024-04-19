part of 'auth_bloc.dart';

@immutable
class AuthState {
  final bool? isUnauthorized;
  final bool? isAuthorized;
  final bool? isChecking;
  final Object? error;

  const AuthState({this.isUnauthorized, this.isAuthorized, this.isChecking,this.error});

  factory AuthState.initial() => const AuthState(
        isAuthorized: false,
        isUnauthorized: false,
        isChecking: false,
      );

  AuthState unauthorized() {
    return copyWith(isUnauthorized: true, isAuthorized: false, isChecking: false);
  }

  AuthState authorized() {
    return copyWith(isAuthorized: true, isUnauthorized: false, isChecking: false);
  }

  AuthState checkingStatus() {
    return copyWith(
      isChecking: true,
      isAuthorized: false,
      isUnauthorized: false,
    );
  }

  AuthState copyWith({
    bool? isUnauthorized,
    bool? isAuthorized,
    bool? isChecking,
    Object? error,
  }) {
    return AuthState(
      isUnauthorized: isUnauthorized ?? this.isUnauthorized,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      isChecking: isChecking ?? this.isChecking,
      error: error ?? this.error,
    );
  }
}
