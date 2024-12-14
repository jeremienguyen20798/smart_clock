class DateTimeUtils {
  static Duration calculateRemainingTime(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.isBefore(now)) {
      int days = now.difference(dateTime).inDays + 1;
      final nextOccurrence = dateTime.add(Duration(days: days));
      return nextOccurrence.difference(now);
    }
    return dateTime.difference(now);
  }
}
