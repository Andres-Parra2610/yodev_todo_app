import 'package:intl/intl.dart';

String getDateString(DateTime? dateString) {
  if (dateString == null) return '';
  return DateFormat('dd/MM/yyyy').format(dateString);
}
