import 'package:intl/intl.dart';
import 'package:product_app/resource/strings.dart';

extension NumberExtensionFunction on num? {

  String convertCurrencyInBottomSheet(double number, bool allowDecimal) {
    if (!allowDecimal) {
      NumberFormat numberFormat = NumberFormat("#,##,##0", "en_US");
      return "${Strings.rupeesText} ${numberFormat.format(number)}";
    } else {
      NumberFormat numberFormat = NumberFormat("#,##,##0.00", "en_US");
      return "${Strings.rupeesText} ${numberFormat.format(number)}";
    }
  }
}
