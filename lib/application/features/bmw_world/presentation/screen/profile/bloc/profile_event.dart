part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();

  factory ProfileEvent.getUser() => const _GetUserEvent();
  factory ProfileEvent.logout() => const _LogoutEvent();
}

final class _GetUserEvent extends ProfileEvent {
  const _GetUserEvent();
}

final class _LogoutEvent extends ProfileEvent {
  const _LogoutEvent();
}
