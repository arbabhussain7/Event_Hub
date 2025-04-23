import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(
              height: 22.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  'Events',
                  style: GoogleFonts.nunito(
                      fontSize: 20.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                SvgPicture.asset(
                  ImageAssets.searchIcon,
                  color: AppColors.blackColor,
                )
              ],
            ),
            SizedBox(
              height: 22.h,
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
                            width: 90.w,
                            height: 111.h,
                          ),
                        ),
                        SizedBox(
                          width: 9.w,
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
                              height: 8.h,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'A virtual evening of \nsmooth jazz',
                              style: GoogleFonts.nunito(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackColor),
                            ),
                            SizedBox(
                              height: 9.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(ImageAssets.locationIcon),
                                Text(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  'Radius Gallery • Santa Cruz, CA',
                                  style: GoogleFonts.nunito(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyColor),
                                ),
                              ],
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
    );
  }
}
