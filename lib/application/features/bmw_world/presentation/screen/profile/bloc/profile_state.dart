part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final Object? profileError;
  final bool? isLoading;
  final bool? isProfileSuccess;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? imageUrl;

  const ProfileState({
    this.profileError,
    this.isLoading,
    this.isProfileSuccess,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
  });

  factory ProfileState.initial() => const ProfileState(
        isLoading: false,
        isProfileSuccess: false,
      );

  ProfileState loading() {
    return copyWith(isLoading: true);
  }

  ProfileState profileErrorState(Object error) {
    return copyWith(profileError: error);
  }

  ProfileState userLoaded({required User user}) {
    return copyWith(
      isProfileSuccess: true,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      imageUrl: user.imageUrl,
      profileError: null,
      isLoading: false,
    );
  }

  ProfileState copyWith({
    Object? profileError,
    bool? isLoading,
    bool? isProfileSuccess,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
  }) {
    return ProfileState(
      profileError: profileError ?? this.profileError,
      isLoading: isLoading ?? this.isLoading,
      isProfileSuccess: isProfileSuccess ?? this.isProfileSuccess,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
