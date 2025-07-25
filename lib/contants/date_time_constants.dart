// ignore_for_file: constant_identifier_names

class DateTimeConstants {
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String dateTimeWithMillisecondsFormat = 'yyyy-MM-dd HH:mm:ss.SSS';
  static const String iso8601Format = 'yyyy-MM-ddTHH:mm:ssZ';

  static const List<String> DAYS_CONSTANT = ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.', 'อา.'];
}

class TimerConstants {
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 20);
  static const Duration RECEIVE_TIMEOUT = Duration(seconds: 10);
}