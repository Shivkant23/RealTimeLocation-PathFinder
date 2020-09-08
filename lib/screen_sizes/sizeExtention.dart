import 'package:SalesTrendz/screen_sizes/Utilityscreen.dart';

extension SizeExtension on num {
  num get w => UtilityScreen().setWidth(this);

  num get h => UtilityScreen().setHeight(this);

  num get sp => UtilityScreen().setSp(this);

  num get ssp => UtilityScreen().setSp(this, allowFontScalingSelf: true);
}