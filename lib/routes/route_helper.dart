import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_details.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  static String getInitial() => '$initial';
  static String getPopularFood() => '$popularFood';
  static String getRecommendedFood() => '$recommendedFood';
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => MainFoodPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: popularFood,
      page: () => PopularFoodDelails(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () => RecommendedFoodDetails(),
      transition: Transition.fadeIn,
    ),
  ];
}
