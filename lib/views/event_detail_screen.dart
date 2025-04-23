import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 244.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.eventImgs))),
                child: Padding(
                  padding: EdgeInsets.only(top: 39.h, left: 12.w, right: 12.w),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                ImageAssets.backIcon,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              'Event Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 182.h,
                left: 33.w,
                child: Container(
                  width: 295.w,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff5A5A5A1A).withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, 20))
                      ],
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.whiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 88.w,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(ImageAssets.oneImg),
                            ),
                            Positioned(
                              left: 22.w,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(ImageAssets.twoImg),
                              ),
                            ),
                            Positioned(
                              left: 44.w,
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage(ImageAssets.thirdImg),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '+20 Going',
                        style: GoogleFonts.nunito(
                            letterSpacing: 0.3,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.blueColor),
                      ),
                      const Icon(
                        Icons.abc_sharp,
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(7.r)),
                        child: Text(
                          'Invite',
                          style: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              'International Band Music Concert',
              style: GoogleFonts.nunito(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor),
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      color: AppColors.aWhiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: SvgPicture.asset(ImageAssets.calendarIcon),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '14 December, 2021',
                      style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Tuesday, 4:00PM - 9:00PM',
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      color: AppColors.aWhiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: SvgPicture.asset(ImageAssets.eventLocIcon),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gala Convention Center',
                      style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '36 Street Golberg Green Islamabad',
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'About Event',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColors.blackColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Hi! I want to build a website where mortgage brokers enter a property address and LTV, and the site shows a list of lenders who service that area and accept that LTV. I will provide all the lender data. The design should be dark-themed (black background, lime green + red accents), and it should show a map of the address entered. There should also be an admin panel for me to add/edit lender data. Can you do this, and how long would it take?',
                style: GoogleFonts.nunito(
                    fontSize: 16.sp, color: AppColors.blackColor),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 12.h),
        child: CustomButton(text: 'BUY TICKET 20\$', onPressed: () {}),
      ),
    );
  }
}
