import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        ImageAssets.backIcon,
                      ),
                    ),
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                    ),
                    const Icon(
                      Icons.track_changes,
                      color: Colors.transparent,
                    )
                  ],
                ),
                SizedBox(
                  height: 44.h,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: CircleAvatar(
                        maxRadius: 66.sp,
                        backgroundImage: AssetImage(ImageAssets.eventImgs),
                      ),
                    ),
                    Positioned(
                        top: 121.h,
                        left: 97.w,
                        child: SvgPicture.asset(ImageAssets.cameraIcon)),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor),
                        color: AppColors.whiteColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: TextFormField(
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 19.w),
                          hintText: 'Ira Membrit',
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor),
                        color: AppColors.whiteColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: TextFormField(
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 19.w),
                          hintText: 'arbabhussain@gamil.com',
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Locations',
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor),
                        color: AppColors.whiteColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: TextFormField(
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 19.w),
                          hintText: 'Bharia Town Phase VII',
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.w, top: 12.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Text(
                        'Save',
                        style: GoogleFonts.nunito(
                            fontSize: 16.r,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteColor),
                      ),
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
