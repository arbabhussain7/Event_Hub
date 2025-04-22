import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/views/bottom_naivgation_bar_screen.dart';
import 'package:event_hub/views/sign_in_screen.dart';
import 'package:event_hub/widgets/custom_button.dart';
import 'package:event_hub/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                Text(
                  'Sign up',
                  style: GoogleFonts.nunito(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor),
                ),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                    text: 'Full name',
                    image: ImageAssets.profileImg,
                    inputType: TextInputType.text,
                    controller: TextEditingController()),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                    text: 'abc@email.com',
                    image: ImageAssets.mailImg,
                    inputType: TextInputType.text,
                    controller: TextEditingController()),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                    text: 'Your password',
                    isPassword: true,
                    image: ImageAssets.lockImg,
                    inputType: TextInputType.text,
                    controller: TextEditingController()),
                SizedBox(
                  height: 22.h,
                ),
                CustomTextField(
                    text: 'Confirm password',
                    isPassword: true,
                    image: ImageAssets.lockImg,
                    inputType: TextInputType.text,
                    controller: TextEditingController()),
                SizedBox(
                  height: 44.h,
                ),
                CustomButton(
                  text: 'SIGN UP',
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
                      Get.to(() => SignInScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: ' Signin',
                                style: GoogleFonts.nunito(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blueColor))
                          ],
                          text: 'Already have an account?',
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
