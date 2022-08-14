import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/home/food_page_body.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.mainColor,
        child: Column(
          children: [
            // Showing The Header.
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: 'Bangladesh', color: AppColors.mainColor),
                        Row(
                          children: [
                            SmallText(text: 'Rajshahi', color: Colors.black54),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        height: Dimensions.height45,
                        width: Dimensions.width45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Showing The Body.
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
        onRefresh: _loadResource);
  }
}
