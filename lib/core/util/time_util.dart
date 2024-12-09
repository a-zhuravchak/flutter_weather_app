class TimeUtils {
  static bool isDayTime() {
    final now = DateTime.now();
    final hour = now.hour;
    return hour >= 6 && hour < 18;
  }
}
