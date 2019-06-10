class TimeFormat {
  static String formatDuration(Duration duration) {
    if (duration == null) return '';
    String hourStr = (duration.inHours % 60).toString().padLeft(2, '0');
    String minuteStr = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String secondStr = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '${hourStr}h ${minuteStr}m ${secondStr}s';
  }
  
  static String formatTime(DateTime time) {
    if (time == null) return '';
    String hourStr = (time.hour).toString().padLeft(2, '0');
    String minuteStr = (time.minute).toString().padLeft(2, '0');
    String secondStr = (time.second).toString().padLeft(2, '0');

    return '$hourStr:$minuteStr:$secondStr';
  }
}