import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        ShowCustomSnackBar('Type in your email address',
            title: 'Email address');
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar('Type in your valid email address',
            title: 'Valid email address');
      } else if (password.isEmpty) {
        ShowCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        ShowCustomSnackBar('Password can not be less than six characters',
            title: 'Password');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            // print('Success registration');
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      // app logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                      // welcome
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sign into your account',
                              style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      // your email
                      AppTextField(
                          textController: emailController,
                          hintText: 'Email',
                          icon: Icons.email),
                      SizedBox(height: Dimensions.height20),
                      // your password
                      AppTextField(
                        textController: passwordController,
                        hintText: 'Password',
                        icon: Icons.password_sharp,
                        isObscure: true,
                      ),

                      SizedBox(height: Dimensions.height20),
                      // tag line
                      Row(
                        children: [
                          Expanded(child: Container()),
                          RichText(
                            text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font16,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          )
                        ],
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      // sign in
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign in",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      // sing up options
                      RichText(
                        text: TextSpan(
                            text: "Don\'t have an account?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => SignUpPage(),
                                        transition: Transition.fade),
                                  text: " Create",
                                  style: TextStyle(
                                      color: AppColors.mainBackColor,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}
