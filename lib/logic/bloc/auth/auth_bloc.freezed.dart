// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginUser,
    required TResult Function(String name, String email, String password)
        registerUser,
    required TResult Function(String email) resetPassword,
    required TResult Function() logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginUser,
    TResult? Function(String name, String email, String password)? registerUser,
    TResult? Function(String email)? resetPassword,
    TResult? Function()? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginUser,
    TResult Function(String name, String email, String password)? registerUser,
    TResult Function(String email)? resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUserEvent value) loginUser,
    required TResult Function(RegisterUserEvent value) registerUser,
    required TResult Function(ResetPasswordEvent value) resetPassword,
    required TResult Function(LogoutEvent value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUserEvent value)? loginUser,
    TResult? Function(RegisterUserEvent value)? registerUser,
    TResult? Function(ResetPasswordEvent value)? resetPassword,
    TResult? Function(LogoutEvent value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUserEvent value)? loginUser,
    TResult Function(RegisterUserEvent value)? registerUser,
    TResult Function(ResetPasswordEvent value)? resetPassword,
    TResult Function(LogoutEvent value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginUserEventImplCopyWith<$Res> {
  factory _$$LoginUserEventImplCopyWith(_$LoginUserEventImpl value,
          $Res Function(_$LoginUserEventImpl) then) =
      __$$LoginUserEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginUserEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginUserEventImpl>
    implements _$$LoginUserEventImplCopyWith<$Res> {
  __$$LoginUserEventImplCopyWithImpl(
      _$LoginUserEventImpl _value, $Res Function(_$LoginUserEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginUserEventImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginUserEventImpl implements LoginUserEvent {
  const _$LoginUserEventImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.loginUser(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserEventImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserEventImplCopyWith<_$LoginUserEventImpl> get copyWith =>
      __$$LoginUserEventImplCopyWithImpl<_$LoginUserEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginUser,
    required TResult Function(String name, String email, String password)
        registerUser,
    required TResult Function(String email) resetPassword,
    required TResult Function() logout,
  }) {
    return loginUser(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginUser,
    TResult? Function(String name, String email, String password)? registerUser,
    TResult? Function(String email)? resetPassword,
    TResult? Function()? logout,
  }) {
    return loginUser?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginUser,
    TResult Function(String name, String email, String password)? registerUser,
    TResult Function(String email)? resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (loginUser != null) {
      return loginUser(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUserEvent value) loginUser,
    required TResult Function(RegisterUserEvent value) registerUser,
    required TResult Function(ResetPasswordEvent value) resetPassword,
    required TResult Function(LogoutEvent value) logout,
  }) {
    return loginUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUserEvent value)? loginUser,
    TResult? Function(RegisterUserEvent value)? registerUser,
    TResult? Function(ResetPasswordEvent value)? resetPassword,
    TResult? Function(LogoutEvent value)? logout,
  }) {
    return loginUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUserEvent value)? loginUser,
    TResult Function(RegisterUserEvent value)? registerUser,
    TResult Function(ResetPasswordEvent value)? resetPassword,
    TResult Function(LogoutEvent value)? logout,
    required TResult orElse(),
  }) {
    if (loginUser != null) {
      return loginUser(this);
    }
    return orElse();
  }
}

abstract class LoginUserEvent implements AuthEvent {
  const factory LoginUserEvent(
      {required final String email,
      required final String password}) = _$LoginUserEventImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserEventImplCopyWith<_$LoginUserEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterUserEventImplCopyWith<$Res> {
  factory _$$RegisterUserEventImplCopyWith(_$RegisterUserEventImpl value,
          $Res Function(_$RegisterUserEventImpl) then) =
      __$$RegisterUserEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, String email, String password});
}

/// @nodoc
class __$$RegisterUserEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterUserEventImpl>
    implements _$$RegisterUserEventImplCopyWith<$Res> {
  __$$RegisterUserEventImplCopyWithImpl(_$RegisterUserEventImpl _value,
      $Res Function(_$RegisterUserEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$RegisterUserEventImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterUserEventImpl implements RegisterUserEvent {
  const _$RegisterUserEventImpl(
      {required this.name, required this.email, required this.password});

  @override
  final String name;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.registerUser(name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterUserEventImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterUserEventImplCopyWith<_$RegisterUserEventImpl> get copyWith =>
      __$$RegisterUserEventImplCopyWithImpl<_$RegisterUserEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginUser,
    required TResult Function(String name, String email, String password)
        registerUser,
    required TResult Function(String email) resetPassword,
    required TResult Function() logout,
  }) {
    return registerUser(name, email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginUser,
    TResult? Function(String name, String email, String password)? registerUser,
    TResult? Function(String email)? resetPassword,
    TResult? Function()? logout,
  }) {
    return registerUser?.call(name, email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginUser,
    TResult Function(String name, String email, String password)? registerUser,
    TResult Function(String email)? resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (registerUser != null) {
      return registerUser(name, email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUserEvent value) loginUser,
    required TResult Function(RegisterUserEvent value) registerUser,
    required TResult Function(ResetPasswordEvent value) resetPassword,
    required TResult Function(LogoutEvent value) logout,
  }) {
    return registerUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUserEvent value)? loginUser,
    TResult? Function(RegisterUserEvent value)? registerUser,
    TResult? Function(ResetPasswordEvent value)? resetPassword,
    TResult? Function(LogoutEvent value)? logout,
  }) {
    return registerUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUserEvent value)? loginUser,
    TResult Function(RegisterUserEvent value)? registerUser,
    TResult Function(ResetPasswordEvent value)? resetPassword,
    TResult Function(LogoutEvent value)? logout,
    required TResult orElse(),
  }) {
    if (registerUser != null) {
      return registerUser(this);
    }
    return orElse();
  }
}

abstract class RegisterUserEvent implements AuthEvent {
  const factory RegisterUserEvent(
      {required final String name,
      required final String email,
      required final String password}) = _$RegisterUserEventImpl;

  String get name;
  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterUserEventImplCopyWith<_$RegisterUserEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetPasswordEventImplCopyWith<$Res> {
  factory _$$ResetPasswordEventImplCopyWith(_$ResetPasswordEventImpl value,
          $Res Function(_$ResetPasswordEventImpl) then) =
      __$$ResetPasswordEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResetPasswordEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResetPasswordEventImpl>
    implements _$$ResetPasswordEventImplCopyWith<$Res> {
  __$$ResetPasswordEventImplCopyWithImpl(_$ResetPasswordEventImpl _value,
      $Res Function(_$ResetPasswordEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ResetPasswordEventImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResetPasswordEventImpl implements ResetPasswordEvent {
  const _$ResetPasswordEventImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.resetPassword(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordEventImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordEventImplCopyWith<_$ResetPasswordEventImpl> get copyWith =>
      __$$ResetPasswordEventImplCopyWithImpl<_$ResetPasswordEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginUser,
    required TResult Function(String name, String email, String password)
        registerUser,
    required TResult Function(String email) resetPassword,
    required TResult Function() logout,
  }) {
    return resetPassword(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginUser,
    TResult? Function(String name, String email, String password)? registerUser,
    TResult? Function(String email)? resetPassword,
    TResult? Function()? logout,
  }) {
    return resetPassword?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginUser,
    TResult Function(String name, String email, String password)? registerUser,
    TResult Function(String email)? resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (resetPassword != null) {
      return resetPassword(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUserEvent value) loginUser,
    required TResult Function(RegisterUserEvent value) registerUser,
    required TResult Function(ResetPasswordEvent value) resetPassword,
    required TResult Function(LogoutEvent value) logout,
  }) {
    return resetPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUserEvent value)? loginUser,
    TResult? Function(RegisterUserEvent value)? registerUser,
    TResult? Function(ResetPasswordEvent value)? resetPassword,
    TResult? Function(LogoutEvent value)? logout,
  }) {
    return resetPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUserEvent value)? loginUser,
    TResult Function(RegisterUserEvent value)? registerUser,
    TResult Function(ResetPasswordEvent value)? resetPassword,
    TResult Function(LogoutEvent value)? logout,
    required TResult orElse(),
  }) {
    if (resetPassword != null) {
      return resetPassword(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordEvent implements AuthEvent {
  const factory ResetPasswordEvent({required final String email}) =
      _$ResetPasswordEventImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordEventImplCopyWith<_$ResetPasswordEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutEventImplCopyWith<$Res> {
  factory _$$LogoutEventImplCopyWith(
          _$LogoutEventImpl value, $Res Function(_$LogoutEventImpl) then) =
      __$$LogoutEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutEventImpl>
    implements _$$LogoutEventImplCopyWith<$Res> {
  __$$LogoutEventImplCopyWithImpl(
      _$LogoutEventImpl _value, $Res Function(_$LogoutEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutEventImpl implements LogoutEvent {
  const _$LogoutEventImpl();

  @override
  String toString() {
    return 'AuthEvent.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginUser,
    required TResult Function(String name, String email, String password)
        registerUser,
    required TResult Function(String email) resetPassword,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginUser,
    TResult? Function(String name, String email, String password)? registerUser,
    TResult? Function(String email)? resetPassword,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginUser,
    TResult Function(String name, String email, String password)? registerUser,
    TResult Function(String email)? resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUserEvent value) loginUser,
    required TResult Function(RegisterUserEvent value) registerUser,
    required TResult Function(ResetPasswordEvent value) resetPassword,
    required TResult Function(LogoutEvent value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUserEvent value)? loginUser,
    TResult? Function(RegisterUserEvent value)? registerUser,
    TResult? Function(ResetPasswordEvent value)? resetPassword,
    TResult? Function(LogoutEvent value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUserEvent value)? loginUser,
    TResult Function(RegisterUserEvent value)? registerUser,
    TResult Function(ResetPasswordEvent value)? resetPassword,
    TResult Function(LogoutEvent value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class LogoutEvent implements AuthEvent {
  const factory LogoutEvent() = _$LogoutEventImpl;
}

/// @nodoc
mixin _$AuthState {
  UserModel? get user => throw _privateConstructorUsedError;
  AuthStatus get authStatus => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({UserModel? user, AuthStatus authStatus, String? error});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? authStatus = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      authStatus: null == authStatus
          ? _value.authStatus
          : authStatus // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel? user, AuthStatus authStatus, String? error});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? authStatus = null,
    Object? error = freezed,
  }) {
    return _then(_$AuthStateImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      authStatus: null == authStatus
          ? _value.authStatus
          : authStatus // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.user, this.authStatus = AuthStatus.initial, this.error});

  @override
  final UserModel? user;
  @override
  @JsonKey()
  final AuthStatus authStatus;
  @override
  final String? error;

  @override
  String toString() {
    return 'AuthState(user: $user, authStatus: $authStatus, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.authStatus, authStatus) ||
                other.authStatus == authStatus) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, authStatus, error);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final UserModel? user,
      final AuthStatus authStatus,
      final String? error}) = _$AuthStateImpl;

  @override
  UserModel? get user;
  @override
  AuthStatus get authStatus;
  @override
  String? get error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
