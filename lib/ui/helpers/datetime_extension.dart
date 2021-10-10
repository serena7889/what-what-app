import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    DateFormat format = DateFormat('E dd MMM yy');
    String formattedDate = format.format(this);
    return formattedDate;
  }
}
