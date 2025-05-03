import 'dart:convert';
import 'dart:developer';
import 'package:eventhub/views/my_booking_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentsController extends GetxController {
  RxBool paymentLoading = false.obs;
  final String publishableKey = "${dotenv.env['PUBLIC_KEY']}";
  final String secretKey = '${dotenv.env['SECRET_KEY']}';

  @override
  void onInit() {
    super.onInit();
    initStripe();
  }

  Future<void> initStripe() async {
    try {
      Stripe.publishableKey = publishableKey;
      await Stripe.instance.applySettings();
      log(
        'Stripe initialized successfully with key: ${publishableKey.substring(0, 10)}...',
      );
    } catch (e) {
      log('Error initializing Stripe: $e');
    }
  }

  // Process payment
  Future<void> makePayment(
    BuildContext context,
    String amount,
    String eventId,
  ) async {
    try {
      paymentLoading.value = true;

      log('Making payment for event: $eventId with amount: $amount');

      // Calculate amount in cents/smallest currency unit
      final calculatedAmount = (double.parse(amount) * 100).round();

      log('Calculated amount in cents: $calculatedAmount');

      // Create payment intent via the API
      final paymentIntentData = await _createPaymentIntent(
        calculatedAmount.toString(),
        'usd',
        eventId,
      );

      if (paymentIntentData == null) {
        paymentLoading.value = false;
        _showErrorSnackbar('Failed to create payment intent');
        return;
      }

      log('Payment intent created successfully');

      // Configure payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Event Hub',
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: Color(0xFF0000FF)),
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
        ),
      );

      log('Payment sheet initialized');

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      log('Payment completed');

      // If we're here, payment succeeded
      paymentLoading.value = false;

      // Show success message and navigate to bookings screen
      _showSuccessSnackbar('Payment completed successfully');

      // Navigate to the bookings screen
      Get.to(() => MyBookingsScreen());
    } catch (e) {
      paymentLoading.value = false;
      log('Payment error: $e');

      if (e is StripeException) {
        if (e.error.code == 'cancelled') {
          log('Payment canceled by user');
          return;
        }
        _showErrorSnackbar('Stripe error: ${e.error.localizedMessage}');
      } else {
        _showErrorSnackbar('Error: ${e.toString()}');
      }
    }
  }

  // Helper method to create payment intent
  // IMPORTANT: This is for TESTING ONLY
  // In production, NEVER expose your secret key in the client app
  Future<Map<String, dynamic>?> _createPaymentIntent(
    String amount,
    String currency,
    String eventId,
  ) async {
    try {
      // FOR TESTING ONLY - Direct API call to Stripe
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
          'payment_method_types[]': 'card',
          'metadata[event_id]': eventId,
          'description': 'Event ticket purchase',
        },
      );

      log('Stripe API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Payment Intent ID: ${responseData['id']}');
        return responseData;
      } else {
        log(
          'Error creating payment intent: ${response.statusCode} - ${response.body}',
        );
        return null;
      }
    } catch (e) {
      log('Exception creating payment intent: $e');
      return null;
    }
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }
}
