import 'library.dart';
import 'my_colors.dart';

class MyParameters {
  final BuildContext context;
  late double height;
  late BorderRadius roundedBorders;
  late TextStyle middleTextStyle;
  late TextStyle middleTextStyleWhite;
  late TextStyle bigTextStyle;
  late TextStyle bigTextStyleWhite;

  MyParameters(this.context) {
    height = MediaQuery.of(context).size.longestSide;
    roundedBorders = BorderRadius.circular(height * 0.01);
    middleTextStyle = TextStyle(
        fontSize: height * 0.03,
        fontWeight: FontWeight.bold,
        color: MyColors.blackColor87!.withOpacity(0.7));
    middleTextStyleWhite = TextStyle(
        fontSize: height * 0.03,
        fontWeight: FontWeight.bold,
        color: MyColors.whiteColor);
    bigTextStyle = TextStyle(
        fontSize: height * 0.05,
        fontWeight: FontWeight.bold,
        color: MyColors.blackColor87!.withOpacity(0.7));
    bigTextStyleWhite = TextStyle(
        fontSize: height * 0.2,
        fontWeight: FontWeight.bold,
        color: MyColors.whiteColor);
  }
}
