part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final Object? profileError;
  final Object? logoutError;
  final bool? isLoading;
  final bool? isProfileSuccess;
  final bool? isLogoutSuccess;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? imageUrl;


  const ProfileState({
    this.profileError,
    this.logoutError,
    this.isLoading,
    this.isProfileSuccess,
    this.isLogoutSuccess,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
  });

  factory ProfileState.initial() => const ProfileState(
        isLoading: false,
        isProfileSuccess: false,
        isLogoutSuccess: false,
      );

  ProfileState loading() {
    return copyWith(isLoading: true);
  }

  ProfileState profileErrorState(Object error) {
    return copyWith(profileError: error);
  }

  ProfileState logoutErrorState(Object error) {
    return copyWith(logoutError: error);
  }

  ProfileState logoutSuccess() {
    return copyWith(isLogoutSuccess: true);
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
    Object? logoutError,
    bool? isLoading,
    bool? isProfileSuccess,
    bool? isLogoutSuccess,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
  }) {
    return ProfileState(
      profileError: profileError ?? this.profileError,
      logoutError: logoutError ?? this.logoutError,
      isLoading: isLoading ?? this.isLoading,
      isProfileSuccess: isProfileSuccess ?? this.isProfileSuccess,
      isLogoutSuccess: isLogoutSuccess ?? this.isLogoutSuccess,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
