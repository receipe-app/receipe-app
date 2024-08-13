part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.getUser({
    required String uid,
    required String email,
  }) = _GetUserEvent;

  const factory UserEvent.addUser({required UserModel user}) = _AddUserEvent;
}
