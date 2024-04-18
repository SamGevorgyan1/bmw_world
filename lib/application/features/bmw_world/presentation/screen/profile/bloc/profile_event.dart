part of 'profile_bloc.dart';

@immutable
class ProfileEvent {
  const ProfileEvent();

  factory ProfileEvent.getUser() => const _GetUserEvent();
}

final class _GetUserEvent extends ProfileEvent {
  const _GetUserEvent();
}
