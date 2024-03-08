import 'package:intl/intl.dart';

extension ToDoubleExt on String {
  // double? get td =>
  //     double.tryParse(td.toString());
  double? parseDouble() {
    return double.tryParse(this);
  }

  String toSGD() {
    return NumberFormat.simpleCurrency(
      name: '',
    ).format(double.tryParse(this)!);
  }
}
