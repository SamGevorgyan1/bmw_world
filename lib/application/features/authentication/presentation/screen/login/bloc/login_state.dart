part of 'login_bloc.dart';

@immutable
class LoginState {
  final Object? loginError;
  final bool? isLoading;
  final bool? isLoginSuccess;

  const LoginState({
    this.loginError,
    this.isLoading,
    this.isLoginSuccess,
  });

  factory LoginState.initial() => const LoginState(isLoading: false, isLoginSuccess: false);

  LoginState loading() {
    return copyWith(isLoading: true);
  }

  LoginState loginSuccess() {
    return copyWith(isLoading: false, isLoginSuccess: true);
  }

  LoginState loginErrorState(Object error) {
    return copyWith(loginError: error, isLoading: false);
  }

  LoginState copyWith({
    Object? loginError,
    bool? isLoading,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      loginError: loginError ?? this.loginError,
      isLoading: isLoading ?? this.isLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }
}
