import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/widgets/custom_button.dart';
import 'package:event_hub/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassewordScreen extends StatelessWidget {
  const ResetPassewordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 17.h,
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(ImageAssets.backIcon)),
              SizedBox(
                height: 22.h,
              ),
              Text(
                'Reset Password',
                style: GoogleFonts.nunito(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blackColor),
              ),
              SizedBox(
                height: 18.h,
              ),
              Text(
                'Please enter your email address to request a password reset',
                style: GoogleFonts.nunito(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
              SizedBox(
                height: 29.h,
              ),
              CustomTextField(
                  text: 'abc@email.com',
                  image: ImageAssets.mailImg,
                  inputType: TextInputType.text,
                  controller: TextEditingController()),
              SizedBox(
                height: 44.h,
              ),
              CustomButton(text: 'SEND', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
