import 'package:intl/intl.dart';

formatDate(DateTime dateTime) {
  String formattedDate = '';
  formattedDate = "${DateFormat("ddMMyyyy").format(dateTime)}";
  return formattedDate;
}

parseDate(DateTime dateTime) {
  String str = '';
  str = "${DateFormat("yyyyMMdd").format(dateTime)}";
  return str;
}
