import 'package:event_hub/constant/assets/assets.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/controllers/auth_controller.dart';
import 'package:event_hub/views/all_events_screen.dart';
import 'package:event_hub/views/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 44.h),
              decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(33.r),
                      bottomRight: Radius.circular(33.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: SvgPicture.asset(ImageAssets.drawerIcon),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Current Location',
                                  style: GoogleFonts.nunito(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.aWhiteColor),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                            Text(
                              'Pakistan',
                              style: GoogleFonts.nunito(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor),
                            )
                          ],
                        ),
                        SvgPicture.asset(ImageAssets.msgIcon)
                      ],
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.searchIcon),
                        SizedBox(
                          width: 12.w,
                        ),
                        Container(
                          width: 1.w,
                          height: 17.h,
                          decoration:
                              BoxDecoration(color: AppColors.aWhiteColor),
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
                                color: AppColors.whiteColor),
                            decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: GoogleFonts.nunito(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        AppColors.aWhiteColor.withOpacity(0.4)),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Events',
                    style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllEventsScreen());
                    },
                    child: Text(
                      'See All',
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            SizedBox(
              height: 255.h,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => EventDetailScreen());
                },
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              ImageAssets.eventImg,
                              width: 250.w,
                              height: 150.h,
                            ),
                            Positioned(
                              left: 12.w,
                              top: 7.h,
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: RichText(
                                  text: TextSpan(
                                      text: '10\n',
                                      style: GoogleFonts.nunito(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.orangeColor),
                                      children: [
                                        TextSpan(
                                            text: 'JUNE',
                                            style: GoogleFonts.nunito(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.orangeColor)),
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Text(
                          'International Band Mu...',
                          style: GoogleFonts.nunito(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.locationIcon),
                            Text(
                              '36 Globla Green Islamabad',
                              style: GoogleFonts.nunito(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.bBlackColor),
                            )
                          ],
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 22.w,
                    );
                  },
                ),
              ),
            ),
            Container(
              width: 328.w,
              height: 127.h,
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                  color: AppColors.cyanColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invite your friends',
                        style: GoogleFonts.nunito(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        'Get \$20 for ticket',
                        style: GoogleFonts.nunito(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bGreyColor),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 9.h),
                        decoration: BoxDecoration(
                            color: AppColors.cyanColor,
                            borderRadius: BorderRadius.circular(7.r)),
                        child: Text(
                          'INVITE',
                          style: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor),
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    ImageAssets.giftImg,
                    width: 141.w,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        width: 242.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 66.h,
              ),
              CircleAvatar(
                maxRadius: 44.sp,
                backgroundImage: AssetImage(ImageAssets.thirdImg),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Ashfak Sayem',
                style: GoogleFonts.nunito(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
              SizedBox(
                height: 55.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(ImageAssets.drawerProIcon),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'My Profile',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.msgIcon,
                    color: AppColors.cGreyColor,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'Message',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.drawerCalIcon,
                    color: AppColors.cGreyColor,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'Calender',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.drawerConIcon,
                    color: AppColors.cGreyColor,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.drawerSettingIcon,
                    color: AppColors.cGreyColor,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'Settings',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.drawerHelpIcon,
                    color: AppColors.cGreyColor,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Text(
                    'Helps & FAQs',
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.logout();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.drawerSignOutIcon,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      'Sign Out',
                      style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
