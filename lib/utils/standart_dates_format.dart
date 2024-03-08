import 'package:intl/intl.dart';

extension ToDateStandard on String {
  toStandardDateTime() {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    var inputDate = inputFormat.parse(this); // <-- dd/MM 24H format
    final df = DateFormat('MMM dd, yyyy hh:mm a');
    var outputDate = df.format(inputDate);
    return outputDate;
  }

  toLocalDateTime( ) {
    int minutes = DateTime.now().timeZoneOffset.inMinutes;
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    var inputDate = inputFormat.parse(this).add(Duration(minutes: minutes));
    final df = DateFormat('MMM dd, yyyy hh:mm a');
    var outputDate = df.format(inputDate);
    return outputDate;
  }
  toLocalDateTimeDDMMYY( ) {
    int minutes = DateTime.now().timeZoneOffset.inMinutes;
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    var inputDate = inputFormat.parse(this).add(Duration(minutes: minutes));
    final df = DateFormat('MMM dd, yyyy');
    var outputDate = df.format(inputDate);
    return outputDate;
  }

  toStandardDate() {
    try {
      var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
      var inputDate = inputFormat.parse(this).add(Duration(minutes: DateTime
          .now()
          .timeZoneOffset
          .inMinutes)); // <-- dd/MM 24H format
      final df = DateFormat('MMM dd, yyyy');
      var outputDate = df.format(inputDate);
      return outputDate;
    }catch(e){
      return 'invalid date';
    }
  }

  toStandardDateNoT() {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(this); // <-- dd/MM 24H format
    final df = DateFormat(' dd/MM/yyyy hh:mm a');
    var outputDate = df.format(inputDate);
    return outputDate;
  }

  toStandardDateForDateTimePicker() {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(this); // <-- dd/MM 24H format
    final df = DateFormat('MMM dd, yyyy');
    var outputDate = df.format(inputDate);
    return outputDate;
  }
}
