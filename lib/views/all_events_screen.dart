import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

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
                height: 12.h,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(ImageAssets.backIcon)),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Search',
                    style: GoogleFonts.nunito(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 22.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.searchIcon,
                    color: AppColors.aBlueColor,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Container(
                    width: 1.w,
                    height: 17.h,
                    decoration:
                        const BoxDecoration(color: AppColors.aWhiteColor),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.aWhiteColor.withOpacity(0.4)),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(22.r)),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.filterIcon),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          'Filters',
                          style: GoogleFonts.nunito(fontSize: 12.sp),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 33.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                          color: AppColors.aWhiteColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              ImageAssets.jazzImg,
                              width: 109.w,
                              height: 122.h,
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1st  May- Sat -2:00 PM',
                                style: GoogleFonts.nunito(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.aBlueColor),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                textAlign: TextAlign.start,
                                'A virtual evening of \nsmooth jazz',
                                style: GoogleFonts.nunito(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blackColor),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
