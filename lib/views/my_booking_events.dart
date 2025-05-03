import 'package:eventhub/constant/assets/assets.dart';
import 'package:eventhub/constant/colors/colors.dart';
import 'package:eventhub/controllers/event_detail_controller.dart';
import 'package:eventhub/models/events_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyBookingsScreen extends StatelessWidget {
  final EventDetailController eventsController =
      Get.find<EventDetailController>();

  MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Bookings',
          style: GoogleFonts.nunito(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.backIcon,
            color: AppColors.blackColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 24.r),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Successful!',
                              style: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Your booking has been confirmed. You\'ll receive details via email shortly.',
                              style: GoogleFonts.nunito(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                Text(
                  'Your Event Tickets',
                  style: GoogleFonts.nunito(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: 16.h),

                // Show the booked event (for demo, showing the selected event)
                Obx(() {
                  final event = eventsController.selectedEvent.value;
                  if (event == null) {
                    return Center(
                      child: Text(
                        'No bookings found',
                        style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color: AppColors.greyColor,
                        ),
                      ),
                    );
                  }

                  return _buildBookingCard(event);
                }),

                SizedBox(height: 24.h),

                // Additional booking information
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.aWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.aBlueColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Information',
                        style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoRow(
                        'Booking ID',
                        '#${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}',
                      ),
                      _buildInfoRow(
                        'Payment Method',
                        'Credit Card (•••• 4242)',
                      ),
                      _buildInfoRow(
                        'Transaction ID',
                        'TXN_${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10)}',
                      ),
                      _buildInfoRow(
                        'Booking Date',
                        DateFormat(
                          'dd MMM yyyy, hh:mm a',
                        ).format(DateTime.now()),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to events screen
                          Get.back();
                          Get.back(); // Go back twice to events list
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'View More Events',
                          style: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    OutlinedButton(
                      onPressed: () {
                        // Download ticket option
                        Get.snackbar(
                          'Coming Soon',
                          'Ticket download will be available soon!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.aBlueColor,
                          colorText: AppColors.whiteColor,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.blueColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 12.w,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download,
                            size: 16.sp,
                            color: AppColors.blueColor,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Tickets',
                            style: GoogleFonts.nunito(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(Event event) {
    String dateTime = '';
    try {
      final dateFormat = DateFormat('dd MMMM yyyy');
      final date = dateFormat.parse(event.eventsDate);
      dateTime = DateFormat('d MMM - EEE').format(date);

      // Extract time from the event day if available
      if (event.eventsDay.contains('PM') || event.eventsDay.contains('AM')) {
        final timeRegex = RegExp(r'\d+:\d+\s*(AM|PM)');
        final match = timeRegex.firstMatch(event.eventsDay);
        if (match != null) {
          dateTime += ' - ${match.group(0)}';
        }
      }
    } catch (e) {
      dateTime = event.eventsDate;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Event image with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child:
                    event.imgUrl.isNotEmpty
                        ? Image.network(
                          event.imgUrl,
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageAssets.eventImgs,
                              width: double.infinity,
                              height: 150.h,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        : Image.asset(
                          ImageAssets.eventImgs,
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.confirmation_number_outlined,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'CONFIRMED',
                        style: GoogleFonts.nunito(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Event details
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventsTitle,
                  style: GoogleFonts.nunito(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16.sp,
                      color: AppColors.aBlueColor,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      dateTime,
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.aBlueColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.locationIcon,
                      width: 16.sp,
                      height: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        '${event.eventsName} • ${event.address}',
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TICKET PRICE',
                          style: GoogleFonts.nunito(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '\$${event.ticketAmont}',
                          style: GoogleFonts.nunito(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUANTITY',
                          style: GoogleFonts.nunito(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '1 Ticket',
                          style: GoogleFonts.nunito(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL',
                          style: GoogleFonts.nunito(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '\$${event.ticketAmont}',
                          style: GoogleFonts.nunito(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
