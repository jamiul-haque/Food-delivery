import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().UserLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // toolbarHeight: Dimensions.height30 * 2,
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          // profile icon
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height45 + Dimensions.height30,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(height: Dimensions.height30),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // name
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: Colors.amber,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.name)),
                                  SizedBox(height: Dimensions.height20),
                                  // phone
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: Colors.amber,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel.phone)),
                                  SizedBox(height: Dimensions.height20),
                                  // email
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: Colors.amber,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel.email)),
                                  SizedBox(height: Dimensions.height20),
                                  // address
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: Colors.amber,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: 'Fill in your address')),
                                  SizedBox(height: Dimensions.height20),
                                  // message
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.amber,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: 'write your message here')),
                                  SizedBox(height: Dimensions.height20),
                                  // message
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .UserLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offAllNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout_outlined,
                                          backgroundColor: Colors.amber,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: 'Logout')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/images/logo1.gif"))),
                        ),
                        SizedBox(height: Dimensions.height20),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
