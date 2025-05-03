// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionException {
  String get message => throw _privateConstructorUsedError;
  dynamic get originalError => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionExceptionCopyWith<SessionException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionExceptionCopyWith<$Res> {
  factory $SessionExceptionCopyWith(
          SessionException value, $Res Function(SessionException) then) =
      _$SessionExceptionCopyWithImpl<$Res, SessionException>;
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class _$SessionExceptionCopyWithImpl<$Res, $Val extends SessionException>
    implements $SessionExceptionCopyWith<$Res> {
  _$SessionExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkSessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$NetworkSessionExceptionImplCopyWith(
          _$NetworkSessionExceptionImpl value,
          $Res Function(_$NetworkSessionExceptionImpl) then) =
      __$$NetworkSessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$NetworkSessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res, _$NetworkSessionExceptionImpl>
    implements _$$NetworkSessionExceptionImplCopyWith<$Res> {
  __$$NetworkSessionExceptionImplCopyWithImpl(
      _$NetworkSessionExceptionImpl _value,
      $Res Function(_$NetworkSessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$NetworkSessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$NetworkSessionExceptionImpl implements NetworkSessionException {
  const _$NetworkSessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.networkError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkSessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkSessionExceptionImplCopyWith<_$NetworkSessionExceptionImpl>
      get copyWith => __$$NetworkSessionExceptionImplCopyWithImpl<
          _$NetworkSessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return networkError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return networkError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class NetworkSessionException implements SessionException {
  const factory NetworkSessionException(
      {required final String message,
      required final dynamic originalError}) = _$NetworkSessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkSessionExceptionImplCopyWith<_$NetworkSessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshSessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$RefreshSessionExceptionImplCopyWith(
          _$RefreshSessionExceptionImpl value,
          $Res Function(_$RefreshSessionExceptionImpl) then) =
      __$$RefreshSessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$RefreshSessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res, _$RefreshSessionExceptionImpl>
    implements _$$RefreshSessionExceptionImplCopyWith<$Res> {
  __$$RefreshSessionExceptionImplCopyWithImpl(
      _$RefreshSessionExceptionImpl _value,
      $Res Function(_$RefreshSessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$RefreshSessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$RefreshSessionExceptionImpl implements RefreshSessionException {
  const _$RefreshSessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.refreshError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshSessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshSessionExceptionImplCopyWith<_$RefreshSessionExceptionImpl>
      get copyWith => __$$RefreshSessionExceptionImplCopyWithImpl<
          _$RefreshSessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return refreshError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return refreshError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (refreshError != null) {
      return refreshError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return refreshError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return refreshError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (refreshError != null) {
      return refreshError(this);
    }
    return orElse();
  }
}

abstract class RefreshSessionException implements SessionException {
  const factory RefreshSessionException(
      {required final String message,
      required final dynamic originalError}) = _$RefreshSessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshSessionExceptionImplCopyWith<_$RefreshSessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationSessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$AuthenticationSessionExceptionImplCopyWith(
          _$AuthenticationSessionExceptionImpl value,
          $Res Function(_$AuthenticationSessionExceptionImpl) then) =
      __$$AuthenticationSessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$AuthenticationSessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res,
        _$AuthenticationSessionExceptionImpl>
    implements _$$AuthenticationSessionExceptionImplCopyWith<$Res> {
  __$$AuthenticationSessionExceptionImplCopyWithImpl(
      _$AuthenticationSessionExceptionImpl _value,
      $Res Function(_$AuthenticationSessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$AuthenticationSessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AuthenticationSessionExceptionImpl
    implements AuthenticationSessionException {
  const _$AuthenticationSessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.authenticationError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationSessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationSessionExceptionImplCopyWith<
          _$AuthenticationSessionExceptionImpl>
      get copyWith => __$$AuthenticationSessionExceptionImplCopyWithImpl<
          _$AuthenticationSessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return authenticationError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return authenticationError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return authenticationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return authenticationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(this);
    }
    return orElse();
  }
}

abstract class AuthenticationSessionException implements SessionException {
  const factory AuthenticationSessionException(
          {required final String message,
          required final dynamic originalError}) =
      _$AuthenticationSessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationSessionExceptionImplCopyWith<
          _$AuthenticationSessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentInfoSessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$StudentInfoSessionExceptionImplCopyWith(
          _$StudentInfoSessionExceptionImpl value,
          $Res Function(_$StudentInfoSessionExceptionImpl) then) =
      __$$StudentInfoSessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$StudentInfoSessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res,
        _$StudentInfoSessionExceptionImpl>
    implements _$$StudentInfoSessionExceptionImplCopyWith<$Res> {
  __$$StudentInfoSessionExceptionImplCopyWithImpl(
      _$StudentInfoSessionExceptionImpl _value,
      $Res Function(_$StudentInfoSessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$StudentInfoSessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$StudentInfoSessionExceptionImpl implements StudentInfoSessionException {
  const _$StudentInfoSessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.studentInfoError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentInfoSessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentInfoSessionExceptionImplCopyWith<_$StudentInfoSessionExceptionImpl>
      get copyWith => __$$StudentInfoSessionExceptionImplCopyWithImpl<
          _$StudentInfoSessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return studentInfoError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return studentInfoError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (studentInfoError != null) {
      return studentInfoError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return studentInfoError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return studentInfoError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (studentInfoError != null) {
      return studentInfoError(this);
    }
    return orElse();
  }
}

abstract class StudentInfoSessionException implements SessionException {
  const factory StudentInfoSessionException(
          {required final String message,
          required final dynamic originalError}) =
      _$StudentInfoSessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentInfoSessionExceptionImplCopyWith<_$StudentInfoSessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PendingSurveySessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$PendingSurveySessionExceptionImplCopyWith(
          _$PendingSurveySessionExceptionImpl value,
          $Res Function(_$PendingSurveySessionExceptionImpl) then) =
      __$$PendingSurveySessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$PendingSurveySessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res,
        _$PendingSurveySessionExceptionImpl>
    implements _$$PendingSurveySessionExceptionImplCopyWith<$Res> {
  __$$PendingSurveySessionExceptionImplCopyWithImpl(
      _$PendingSurveySessionExceptionImpl _value,
      $Res Function(_$PendingSurveySessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$PendingSurveySessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$PendingSurveySessionExceptionImpl
    implements PendingSurveySessionException {
  const _$PendingSurveySessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.pendingSurveyError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingSurveySessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingSurveySessionExceptionImplCopyWith<
          _$PendingSurveySessionExceptionImpl>
      get copyWith => __$$PendingSurveySessionExceptionImplCopyWithImpl<
          _$PendingSurveySessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return pendingSurveyError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return pendingSurveyError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (pendingSurveyError != null) {
      return pendingSurveyError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return pendingSurveyError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return pendingSurveyError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (pendingSurveyError != null) {
      return pendingSurveyError(this);
    }
    return orElse();
  }
}

abstract class PendingSurveySessionException implements SessionException {
  const factory PendingSurveySessionException(
          {required final String message,
          required final dynamic originalError}) =
      _$PendingSurveySessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingSurveySessionExceptionImplCopyWith<
          _$PendingSurveySessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownSessionExceptionImplCopyWith<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  factory _$$UnknownSessionExceptionImplCopyWith(
          _$UnknownSessionExceptionImpl value,
          $Res Function(_$UnknownSessionExceptionImpl) then) =
      __$$UnknownSessionExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, dynamic originalError});
}

/// @nodoc
class __$$UnknownSessionExceptionImplCopyWithImpl<$Res>
    extends _$SessionExceptionCopyWithImpl<$Res, _$UnknownSessionExceptionImpl>
    implements _$$UnknownSessionExceptionImplCopyWith<$Res> {
  __$$UnknownSessionExceptionImplCopyWithImpl(
      _$UnknownSessionExceptionImpl _value,
      $Res Function(_$UnknownSessionExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? originalError = freezed,
  }) {
    return _then(_$UnknownSessionExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      originalError: freezed == originalError
          ? _value.originalError
          : originalError // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$UnknownSessionExceptionImpl implements UnknownSessionException {
  const _$UnknownSessionExceptionImpl(
      {required this.message, required this.originalError});

  @override
  final String message;
  @override
  final dynamic originalError;

  @override
  String toString() {
    return 'SessionException.unknownError(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownSessionExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.originalError, originalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(originalError));

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownSessionExceptionImplCopyWith<_$UnknownSessionExceptionImpl>
      get copyWith => __$$UnknownSessionExceptionImplCopyWithImpl<
          _$UnknownSessionExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, dynamic originalError)
        networkError,
    required TResult Function(String message, dynamic originalError)
        refreshError,
    required TResult Function(String message, dynamic originalError)
        authenticationError,
    required TResult Function(String message, dynamic originalError)
        studentInfoError,
    required TResult Function(String message, dynamic originalError)
        pendingSurveyError,
    required TResult Function(String message, dynamic originalError)
        unknownError,
  }) {
    return unknownError(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, dynamic originalError)? networkError,
    TResult? Function(String message, dynamic originalError)? refreshError,
    TResult? Function(String message, dynamic originalError)?
        authenticationError,
    TResult? Function(String message, dynamic originalError)? studentInfoError,
    TResult? Function(String message, dynamic originalError)?
        pendingSurveyError,
    TResult? Function(String message, dynamic originalError)? unknownError,
  }) {
    return unknownError?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, dynamic originalError)? networkError,
    TResult Function(String message, dynamic originalError)? refreshError,
    TResult Function(String message, dynamic originalError)?
        authenticationError,
    TResult Function(String message, dynamic originalError)? studentInfoError,
    TResult Function(String message, dynamic originalError)? pendingSurveyError,
    TResult Function(String message, dynamic originalError)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkSessionException value) networkError,
    required TResult Function(RefreshSessionException value) refreshError,
    required TResult Function(AuthenticationSessionException value)
        authenticationError,
    required TResult Function(StudentInfoSessionException value)
        studentInfoError,
    required TResult Function(PendingSurveySessionException value)
        pendingSurveyError,
    required TResult Function(UnknownSessionException value) unknownError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkSessionException value)? networkError,
    TResult? Function(RefreshSessionException value)? refreshError,
    TResult? Function(AuthenticationSessionException value)?
        authenticationError,
    TResult? Function(StudentInfoSessionException value)? studentInfoError,
    TResult? Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult? Function(UnknownSessionException value)? unknownError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkSessionException value)? networkError,
    TResult Function(RefreshSessionException value)? refreshError,
    TResult Function(AuthenticationSessionException value)? authenticationError,
    TResult Function(StudentInfoSessionException value)? studentInfoError,
    TResult Function(PendingSurveySessionException value)? pendingSurveyError,
    TResult Function(UnknownSessionException value)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class UnknownSessionException implements SessionException {
  const factory UnknownSessionException(
      {required final String message,
      required final dynamic originalError}) = _$UnknownSessionExceptionImpl;

  @override
  String get message;
  @override
  dynamic get originalError;

  /// Create a copy of SessionException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownSessionExceptionImplCopyWith<_$UnknownSessionExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
