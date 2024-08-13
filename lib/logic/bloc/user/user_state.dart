part of 'user_bloc.dart';

enum UserStatus { initial, loading, loaded, error }

@freezed
class UserState with _$UserState {
  const factory UserState({
    UserModel? user,
    @Default(UserStatus.initial) UserStatus userStatus,
    String? error,
  }) = _UserState;
}
