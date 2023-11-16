import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_breathe/model/settings.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier([AppState? appState]) : super(appState ?? AppState());

  void toggleZenMode() {
    state = state.copyWith(isZenMode: !state.isZenMode);
  }

  void togglePlaySounds() {
    state = state.copyWith(playSounds: !state.playSounds);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void setDuration(Duration duration) {
    state = state.copyWith(duration: duration);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
