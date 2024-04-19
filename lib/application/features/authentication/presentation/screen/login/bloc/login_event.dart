part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();

  factory LoginEvent.emailAndPassword(String email, String password) =>
      _LoginWithEmailPassword(email, password);
}

final class _LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;

  const _LoginWithEmailPassword(this.email, this.password);
}
