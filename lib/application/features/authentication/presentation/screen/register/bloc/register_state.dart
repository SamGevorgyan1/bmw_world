part of 'register_bloc.dart';

@immutable
class RegisterState {
  final Object? registerError;
  final Object? verificationError;
  final Object? loginError;
  final bool? isLoginLoading;
  final bool? isLoading;
  final bool? canVerify;
  final bool? isLoginSuccess;
  final bool? isRegistrationSuccess;
  final bool? isVerificationSuccess;
  final String? email;
  final String? password;

  const RegisterState({
    this.registerError,
    this.verificationError,
    this.loginError,
    this.isLoginLoading,
    this.isLoading,
    this.canVerify,
    this.isLoginSuccess,
    this.isRegistrationSuccess,
    this.isVerificationSuccess,
    this.email,
    this.password,
  });

  factory RegisterState.initial() => const RegisterState(
        isLoading: false,
        canVerify: false,
        isVerificationSuccess: false,
        isRegistrationSuccess: false,
        isLoginSuccess: false,
        isLoginLoading: false,
      );

  RegisterState loading() {
    return copyWith(isLoading: true);
  }

  RegisterState registrationErrorState(Object error) {
    return copyWith(registerError: error);
  }

  RegisterState loginErrorState(Object error) {
    return copyWith(loginError: error, isLoginLoading: false);
  }
  RegisterState verifyErrorState(Object error) {
    return copyWith(verificationError: error);
  }

  RegisterState loginSuccess() {
    return copyWith(isLoginSuccess: true, isLoginLoading: false);
  }

  RegisterState enableVerification() {
    return copyWith(canVerify: true);
  }

  RegisterState verificationSuccess() {
    return copyWith(isVerificationSuccess: true);
  }

  RegisterState registrationSuccess(String email, String password) {
    return copyWith(
      isRegistrationSuccess: true,
      email: email,
      password: password,
      registerError: null,
      isLoading: false,
      canVerify: true,
    );
  }

  RegisterState copyWith({
    Object? registerError,
    Object? verificationError,
    Object? loginError,
    bool? isLoginLoading,
    bool? isLoading,
    bool? canVerify,
    bool? isLoginSuccess,
    bool? isRegistrationSuccess,
    bool? isVerificationSuccess,
    String? email,
    String? password,
  }) {
    return RegisterState(
      registerError: registerError ?? this.registerError,
      verificationError: verificationError ?? this.verificationError,
      loginError: loginError ?? this.loginError,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isLoading: isLoading ?? this.isLoading,
      canVerify: canVerify ?? this.canVerify,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isRegistrationSuccess: isRegistrationSuccess ?? this.isRegistrationSuccess,
      isVerificationSuccess: isVerificationSuccess ?? this.isVerificationSuccess,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
