import 'dart:async';

import 'package:bmw_world/domain/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoaderViewCubitState { unknown, authorized, notAuthorized }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(
    LoaderViewCubitState initialState,
    this.authBloc,
  ) : super(initialState) {
    Future.microtask(
      () {
        _onState(authBloc.state);
        authBlocSubscription = authBloc.stream.listen(_onState);
        authBloc.add(AuthCheckStatusEvent());
      },
    );
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
