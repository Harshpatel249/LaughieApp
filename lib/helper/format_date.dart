import 'package:intl/intl.dart';

//helps to format a DateTime object to a custom conventional string(ddMMyyyy)
formatDate(DateTime dateTime) {
  String formattedDate = '';
  formattedDate = "${DateFormat("ddMMyyyy").format(dateTime)}";
  return formattedDate;
}

//helps to create a DateTime object with time parameter set to zero.
DateTime parseDate(DateTime dateTime) {
  String str = '';
  str = "${DateFormat("yyyyMMdd").format(dateTime)}";
  return DateTime.parse(str);
}
