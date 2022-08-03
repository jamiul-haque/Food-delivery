import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.8;
  static double pageViewContainer = screenHeight / 4.1;
  static double pageViewTextContainer = screenHeight / 7.5;

  // dynamic height padding and margin
  static double height10 = screenHeight / 90;
  static double height15 = screenHeight / 60;
  static double height20 = screenHeight / 45;
  static double height30 = screenHeight / 30;
  static double height45 = screenHeight / 20;

  // dynamic width padding and margin
  static double width10 = screenHeight / 90;
  static double width15 = screenHeight / 60;
  static double width20 = screenHeight / 45;
  static double width30 = screenHeight / 30;
  static double width45 = screenHeight / 20;

  static double font20 = screenHeight / 45;

  // radius
  static double radius20 = screenHeight / 45;
  static double radius15 = screenHeight / 60;
  static double radius30 = screenHeight / 30;
}
