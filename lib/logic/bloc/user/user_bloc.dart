import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receipe_app/data/model/user_model.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState()) {
    on<_GetUserEvent>(_onGetUser);
    on<_AddUserEvent>(_onAddUser);
  }

  void _onGetUser(
    _GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    final appResponse =
        await _userRepository.getUser(uid: event.uid, email: event.email);
    if (appResponse.isSuccess && appResponse.errorMessage == '') {
    } else {
      emit(state.copyWith(error: appResponse.errorMessage));
    }
  }

  void _onAddUser(
    _AddUserEvent event,
    Emitter<UserState> emit,
  ) {}
}
