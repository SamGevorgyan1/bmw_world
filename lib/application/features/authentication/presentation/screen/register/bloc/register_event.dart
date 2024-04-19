part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {
  const RegisterEvent();

  factory RegisterEvent.registerButtonPressed({
    required String email,
    required String fistName,
    required String lastName,
    required String password,
  }) =>
      _RegisterButtonPressedEvent(
        email: email,
        firstName: fistName,
        lastName: lastName,
        password: password,
      );

  factory RegisterEvent.sendVerificationCode() => const _SendVerificationCode();

  factory RegisterEvent.verify(String verifyCode) => _VerifyUserEvent(verifyCode);

  factory RegisterEvent.login() => const _LoginEvent();
}

final class _RegisterButtonPressedEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const _RegisterButtonPressedEvent({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
}

final class _SendVerificationCode extends RegisterEvent {
  const _SendVerificationCode();
}

final class _VerifyUserEvent extends RegisterEvent {
  final String verifyCode;

  const _VerifyUserEvent(this.verifyCode);
}

final class _LoginEvent extends RegisterEvent {
  const _LoginEvent();
}
