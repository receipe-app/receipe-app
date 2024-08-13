import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepository;

  AuthBloc({required AuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_onRegisterUser);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onLogoutUser);
  }

  void _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await _authRepository.login(email: event.email, password: event.password);
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  void _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await _authRepository.register(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) {
    // _authRepository.resetPassword(email: event.email);
  }

  void _onLogoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      log('log out event');
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  // void _onCheckTokenExpiry(CheckTokenExpiryEvent event, emit) async {
  //   emit(LoadingAuthState());
  //   final user = await _authRepository.checkTokenExpiry();
  //   if (user != null) {
  //     emit(AuthenticatedAuthState(user));
  //   } else {
  //     emit(UnAuthenticatedAuthState());
  //   }
  // }
}
