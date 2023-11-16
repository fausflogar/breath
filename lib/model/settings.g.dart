// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppStateCWProxy {
  AppState isZenMode(bool isZenMode);

  AppState playSounds(bool playSounds);

  AppState isDarkMode(bool isDarkMode);

  AppState duration(Duration duration);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppState(...).copyWith(id: 12, name: "My name")
  /// ````
  AppState call({
    bool? isZenMode,
    bool? playSounds,
    bool? isDarkMode,
    Duration? duration,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppState.copyWith.fieldName(...)`
class _$AppStateCWProxyImpl implements _$AppStateCWProxy {
  const _$AppStateCWProxyImpl(this._value);

  final AppState _value;

  @override
  AppState isZenMode(bool isZenMode) => this(isZenMode: isZenMode);

  @override
  AppState playSounds(bool playSounds) => this(playSounds: playSounds);

  @override
  AppState isDarkMode(bool isDarkMode) => this(isDarkMode: isDarkMode);

  @override
  AppState duration(Duration duration) => this(duration: duration);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppState(...).copyWith(id: 12, name: "My name")
  /// ````
  AppState call({
    Object? isZenMode = const $CopyWithPlaceholder(),
    Object? playSounds = const $CopyWithPlaceholder(),
    Object? isDarkMode = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
  }) {
    return AppState(
      isZenMode: isZenMode == const $CopyWithPlaceholder() || isZenMode == null
          ? _value.isZenMode
          // ignore: cast_nullable_to_non_nullable
          : isZenMode as bool,
      playSounds:
          playSounds == const $CopyWithPlaceholder() || playSounds == null
              ? _value.playSounds
              // ignore: cast_nullable_to_non_nullable
              : playSounds as bool,
      isDarkMode:
          isDarkMode == const $CopyWithPlaceholder() || isDarkMode == null
              ? _value.isDarkMode
              // ignore: cast_nullable_to_non_nullable
              : isDarkMode as bool,
      duration: duration == const $CopyWithPlaceholder() || duration == null
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as Duration,
    );
  }
}

extension $AppStateCopyWith on AppState {
  /// Returns a callable class that can be used as follows: `instanceOfAppState.copyWith(...)` or like so:`instanceOfAppState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppStateCWProxy get copyWith => _$AppStateCWProxyImpl(this);
}
