extension DurationX on Duration {
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String toMinutesSeconds() {
    final negativeSign = isNegative ? '- ' : '';
    final twoDigitMinutes = inMinutes.remainder(60).abs().toString();
    final twoDigitSeconds = _twoDigits(inSeconds.remainder(60).abs());
    return '$negativeSign$twoDigitMinutes:$twoDigitSeconds';
  }

  String toHoursMinutesSeconds() {
    final negativeSign = isNegative ? '- ' : '';
    final twoDigitMinutes = _twoDigits(inMinutes.remainder(60).abs());
    final twoDigitSeconds = _twoDigits(inSeconds.remainder(60).abs());
    return '$negativeSign${_twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
