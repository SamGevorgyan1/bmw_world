part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();

  factory AuthEvent.checkStatus() => const _AuthCheckStatusEvent();
}

final class _AuthCheckStatusEvent extends AuthEvent {
  const _AuthCheckStatusEvent();
}
