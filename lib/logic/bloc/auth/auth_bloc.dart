import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/model/app_resposne.dart';
import 'package:receipe_app/data/service/dio/user_dio_service.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';
import '../../../data/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepository;
  final UserDioService _userDioService = UserDioService();
  final UserPrefsService _userPrefsService = UserPrefsService();

  AuthBloc({required AuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_onRegisterUser);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onLogoutUser);
    on<CheckTokenExpiryEvent>(_onCheckTokenExpiry);
  }

  void _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final responseUser = await _authRepository.login(
          email: event.email, password: event.password);

      final AppResponse appResponse = await _userDioService.getUser(
        uid: responseUser.id,
        email: responseUser.email,
      );

      if (appResponse.isSuccess && appResponse.errorMessage.isEmpty) {
        final UserModel userModel = appResponse.data;

        UserConstants.saveUserData(userModel: userModel);

        await _userPrefsService.updateUserData(user: userModel);
      }
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  void _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      final response = await _authRepository.register(
        email: event.email,
        password: event.password,
      );
      final data = UserModel(
        id: 'id',
        uid: response.id,
        imageUrl: 'null',
        name: event.name,
        email: event.email,
        savedRecipesId: ['savedRecipesId'],
        likedRecipesId: ['likedRecipesId'],
      );

      await _userDioService.addUser(user: data);
      await _userPrefsService.updateUserData(user: data);
      UserConstants.saveUserData(userModel: data);

      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) {
    // _authRepository.resetPassword(email: event.email);
  }

  void _onCheckTokenExpiry(
    CheckTokenExpiryEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final user = await _authRepository.checkTokenExpiry();
      if (user != null) {
        emit(state.copyWith(authStatus: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }

  void _onLogoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      _authRepository.clearTokens();
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, error: e.toString()));
    }
  }
}
