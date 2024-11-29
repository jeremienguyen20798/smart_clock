class DateTimeUtils {
  static Duration calculateRemainingTime(DateTime dateTime) {
    if (dateTime.isBefore(DateTime.now())) {
      int days = DateTime.now().difference(dateTime).inDays + 1;
      return dateTime.add(Duration(days: days)).difference(DateTime.now());
    }
    return dateTime.difference(DateTime.now());
  }
}
