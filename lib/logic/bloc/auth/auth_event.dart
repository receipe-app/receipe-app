part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginUser({
    required String email,
    required String password,
  }) = LoginUserEvent;

  const factory AuthEvent.registerUser({
    required String name,
    required String email,
    required String password,
  }) = RegisterUserEvent;

  const factory AuthEvent.resetPassword({required String email}) =
      ResetPasswordEvent;

  const factory AuthEvent.checkTokenExpiry() = CheckTokenExpiryEvent;

  const factory AuthEvent.logout() = LogoutEvent;
}
