import 'package:eventhub/constant/assets/assets.dart';
import 'package:eventhub/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          'Contact Us',
          style: GoogleFonts.nunito(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                Center(
                  child: Image.asset(
                    ImageAssets.eventImgs,
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 30.h),

                // Title
                Text(
                  'Get In Touch',
                  style: GoogleFonts.nunito(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Have questions or need assistance? Reach out to us through any of the contact methods below.',
                  style: GoogleFonts.nunito(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor,
                  ),
                ),

                SizedBox(height: 30.h),

                // Contact Cards
                _buildContactCard(
                  icon: Icons.phone,
                  title: 'Phone Number',
                  subtitle: '+223471717171',
                  onTap: () => _makePhoneCall('+223471717171'),
                  actionText: 'Call',
                  actionIcon: Icons.call,
                  copyable: true,
                ),

                SizedBox(height: 16.h),

                _buildContactCard(
                  icon: Icons.email,
                  title: 'Email Address',
                  subtitle: 'kainatAmir121@gmail.com',
                  onTap: () => _sendEmail('kainatAmir121@gmail.com'),
                  actionText: 'Email',
                  actionIcon: Icons.send,
                  copyable: true,
                ),

                SizedBox(height: 16.h),

                _buildContactCard(
                  icon: Icons.location_on,
                  title: 'Office Address',
                  subtitle: '123 Event Street, Islamabad',
                  onTap:
                      () => _openMap('123 Event Street, Islamabad, Pakistan'),
                  actionText: 'Map',
                  actionIcon: Icons.map,
                  copyable: false,
                ),

                SizedBox(height: 30.h),

                // Social Media Section
                Text(
                  'Follow Us',
                  style: GoogleFonts.nunito(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: Icons.facebook,
                      color: Color(0xFF1877F2),
                      onTap: () => _launchUrl('https://facebook.com'),
                    ),
                    SizedBox(width: 24.w),
                    _buildSocialButton(
                      icon: Icons.message,
                      color: Color(0xFF1DA1F2),
                      onTap: () => _launchUrl('https://twitter.com'),
                    ),
                    SizedBox(width: 24.w),
                    _buildSocialButton(
                      icon: Icons.camera_alt,
                      color: Color(0xFFE1306C),
                      onTap: () => _launchUrl('https://instagram.com'),
                    ),
                    SizedBox(width: 24.w),
                    _buildSocialButton(
                      icon: Icons.ondemand_video,
                      color: Color(0xFFFF0000),
                      onTap: () => _launchUrl('https://youtube.com'),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Contact Form Section
                Text(
                  'Send Us a Message',
                  style: GoogleFonts.nunito(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: 16.h),

                // Name Field
                _buildTextField(
                  hintText: 'Your Name',
                  prefixIcon: Icons.person_outline,
                ),

                SizedBox(height: 16.h),

                // Email Field
                _buildTextField(
                  hintText: 'Your Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 16.h),

                // Message Field
                Material(
                  color: Colors.transparent,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Your Message',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        color: AppColors.greyColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: AppColors.greyColor.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: AppColors.blueColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16.r),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        'Message Sent',
                        'Thank you for reaching out! We\'ll get back to you soon.',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.all(10),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Business Hours
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.aWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.aBlueColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Hours',
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildBusinessHour(
                        'Monday - Friday',
                        '9:00 AM - 6:00 PM',
                      ),
                      _buildBusinessHour('Saturday', '10:00 AM - 4:00 PM'),
                      _buildBusinessHour('Sunday', 'Closed'),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required String actionText,
    required IconData actionIcon,
    required bool copyable,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 46.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: AppColors.blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.blueColor, size: 22.sp),
          ),
          SizedBox(width: 12.w),

          // Text content - using Expanded to contain overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    // Use Expanded to ensure text wraps properly
                    Expanded(
                      child: Text(
                        subtitle,
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyColor,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (copyable)
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: subtitle));
                          Get.snackbar(
                            'Copied',
                            '$title copied to clipboard',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.aBlueColor,
                            colorText: Colors.white,
                            margin: EdgeInsets.all(10),
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.copy,
                            size: 16.sp,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Action button - fixed width to prevent overflow
          Material(
            color: AppColors.blueColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(actionIcon, size: 16.sp, color: AppColors.blueColor),
                    SizedBox(width: 4.w),
                    Text(
                      actionText,
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: color, size: 24.sp),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(
            fontSize: 16.sp,
            color: AppColors.greyColor,
          ),
          prefixIcon: Icon(prefixIcon, color: AppColors.greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.blueColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessHour(String day, String hours) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.nunito(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
          ),
          Text(
            hours,
            style: GoogleFonts.nunito(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: day == 'Sunday' ? Colors.red : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch phone call: $e');
      Get.snackbar(
        'Error',
        'Could not launch phone call',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _sendEmail(String email) async {
    try {
      final Uri launchUri = Uri(scheme: 'mailto', path: email);
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch email: $e');
      Get.snackbar(
        'Error',
        'Could not launch email app',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _openMap(String address) async {
    try {
      final Uri launchUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
      );
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not open map: $e');
      Get.snackbar(
        'Error',
        'Could not open map',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch URL: $e');
      Get.snackbar(
        'Error',
        'Could not open link',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
