import 'package:intl/intl.dart';

formatDate(DateTime dateTime) {
  String formattedDate = '';
  formattedDate = "${DateFormat("ddMMyyyy").format(dateTime)}";
  return formattedDate;
}

DateTime parseDate(DateTime dateTime) {
  String str = '';
  str = "${DateFormat("yyyyMMdd").format(dateTime)}";
  return DateTime.parse(str);
}
