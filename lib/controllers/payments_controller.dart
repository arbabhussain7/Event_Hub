import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentsController extends GetxController {
  RxBool paymentLoading = false.obs;

  // IMPORTANT: Use only publishable key in client code
  // Move this to a constants file or .env file in production
  final String publishableKey =
      "pk_test_51Q1nGrFHugyQIn2JR0ahzYGnLG5OZLB37WqPt8COaoFSWwKZG2QV6ZzJ7NdWvGjiISxFGjkVzGQQ9VPnV2Jjnqwu00r3QmHaLe";

  // For demo purposes, we're using a cloud function URL (replace with your actual endpoint)
  final String stripeServerUrl =
      "https://us-central1-eventhub-12345.cloudfunctions.net/stripePaymentIntentRequest";

  @override
  void onInit() {
    super.onInit();
    // Initialize Stripe in the controller
    initStripe();
  }

  Future<void> initStripe() async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  // Process payment
  Future<void> makePayment(
    BuildContext context,
    String amount,
    String productId,
  ) async {
    try {
      paymentLoading.value = true;

      // Calculate amount in cents/smallest currency unit
      final calculatedAmount = (double.parse(amount) * 100).round().toString();

      // Create payment intent via the API
      final paymentIntentData = await _createPaymentIntent(
        calculatedAmount,
        'usd',
        productId,
      );

      if (paymentIntentData == null) {
        paymentLoading.value = false;
        _showErrorSnackbar('Failed to create payment intent');
        return;
      }

      // Configure payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Event Hub',
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF0000FF),
            ),
          ),
          // Add this to help with the package name issue
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // If we're here, payment succeeded
      paymentLoading.value = false;
      _showSuccessSnackbar('Payment completed successfully');
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
  Future<Map<String, dynamic>?> _createPaymentIntent(
    String amount,
    String currency,
    String productId,
  ) async {
    try {
      // For demo purposes, we're using the server approach,
      // but with a direct API call (NOT RECOMMENDED FOR PRODUCTION)
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Q1nGrFHugyQIn2JHZlhRarixRFCOqlbsNrOZ9BdwtrVbkD5b8G66lu151uRL73zlA07SBdvd5OTo9DMV5W6Q6U500vY4cvOil',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
          'payment_method_types[]': 'card',
          'metadata[product_id]': productId,
          // This might help with the security exception
          'capture_method': 'automatic',
        },
      );

      log('Stripe API Response: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('Error creating payment intent: ${response.statusCode} - ${response.body}');
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
