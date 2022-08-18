import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImages = [
      't.png',
      'g.png',
      'f.png',
    ];
    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        ShowCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        ShowCustomSnackBar('Type in your phone number', title: 'Phone number');
      } else if (email.isEmpty) {
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
        // ShowCustomSnackBar('All went well', title: 'Perfect');
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        // print(signUpBody.toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print('Success registration');
          } else {
            ShowCustomSnackBar(status.message);
            // print('registration feild');
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
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
                        // your name
                        AppTextField(
                            textController: nameController,
                            hintText: 'Name',
                            icon: Icons.person),
                        SizedBox(height: Dimensions.height20),
                        // your phone
                        AppTextField(
                            textController: phoneController,
                            hintText: 'Phone',
                            icon: Icons.phone),
                        SizedBox(height: Dimensions.height30),
                        // sing up button
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
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
                                text: "Sign up",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        // tag line
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                text: "Have an account already?",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16,
                                ))),
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        // sing up options
                        RichText(
                            text: TextSpan(
                                text:
                                    "Sing up using on of the following methods",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16,
                                ))),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: Dimensions.radius30,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          'assets/images/' +
                                              singUpImages[index]),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
