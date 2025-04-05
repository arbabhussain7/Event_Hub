import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/controllers/textfield_controller.dart';
import 'package:event_hub/views/bottom_naivgation_bar_screen.dart';
import 'package:event_hub/views/home_screen.dart';
import 'package:event_hub/views/reset_passeword_screen.dart';
import 'package:event_hub/views/sign_out_screen.dart';
import 'package:event_hub/widgets/custom_button.dart';
import 'package:event_hub/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final CustomTextFieldController textFieldController =
      Get.put(CustomTextFieldController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 33.h,
                ),
                Center(child: SvgPicture.asset(ImageAssets.loginIcon)),
                SizedBox(
                  height: 33.h,
                ),
                Text(
                  'Sign in',
                  style: GoogleFonts.nunito(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor),
                ),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                  text: 'abc@email.com',
                  image: ImageAssets.mailImg,
                  controller: TextEditingController(),
                  validator: null,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                  text: 'Your password',
                  image: ImageAssets.lockImg,
                  controller: TextEditingController(),
                  validator: null,
                  inputType: TextInputType.emailAddress,
                  isPassword: true,
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.abc,
                      color: Colors.transparent,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ResetPassewordScreen());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.nunito(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                CustomButton(
                  text: 'SIGN IN',
                  onPressed: () {
                    Get.to(() => BottomNavigationBarScreen());
                  },
                ),
                SizedBox(
                  height: 22.h,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  padding: EdgeInsets.symmetric(vertical: 17.h),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.aWhiteColor.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(15, 0))
                      ],
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.googleIcon,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        'Login with Google',
                        style: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.aBlackColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  padding: EdgeInsets.symmetric(vertical: 17.h),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.aWhiteColor.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(15, 0))
                      ],
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.fbIcon,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        'Login with Google',
                        style: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.aBlackColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SignOutScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: ' Sign up',
                                style: GoogleFonts.nunito(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blueColor))
                          ],
                          text: 'Don’t have an account?',
                          style: GoogleFonts.nunito(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.aBlackColor)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
