import 'package:intl/intl.dart';

formatDate(DateTime dateTime) {
  String formattedDate = '';
  formattedDate = "${DateFormat("ddMMyyyy").format(dateTime)}";
  return formattedDate;
}
