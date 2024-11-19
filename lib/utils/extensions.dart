extension DurationFormats on Duration {
  /// Converts duration into H:MM:SS format
  String clockFmt() {
    final String hours = inHours.toString().padLeft(2, '0');
    final String minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds = inSeconds.remainder(60).toString().padLeft(2, '0');

    if (inHours >= 1) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }
}
