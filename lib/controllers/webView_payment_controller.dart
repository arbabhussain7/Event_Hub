// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewPaymentController extends GetxController {
//   RxBool isLoading = false.obs;
//   final String apiKey =
//       "sk_test_51Q1nGrFHugyQIn2JHZlhRarixRFCOqlbsNrOZ9BdwtrVbkD5b8G66lu151uRL73zlA07SBdvd5OTo9DMV5W6Q6U500vY4cvOil";

//   // Create payment intent on your server or directly (for testing only)
//   Future<Map<String, dynamic>?> createPaymentIntent(
//       String amount, String productId) async {
//     try {
//       isLoading.value = true;

//       final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

//       final headers = {
//         'Authorization': 'Bearer $apiKey',
//         'Content-Type': 'application/x-www-form-urlencoded'
//       };

//       final body = {
//         'amount': (double.parse(amount) * 100).toStringAsFixed(0),
//         'currency': 'usd',
//         'payment_method_types[]': 'card',
//         'metadata[product_id]': productId,
//       };

//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );

//       print("Stripe API Response: ${response.body}");

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print(
//             "Error creating payment intent: ${response.statusCode}, ${response.body}");
//         return null;
//       }
//     } catch (e) {
//       print("Exception creating payment intent: $e");
//       return null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Process payment through direct Stripe checkout
//   void processPayment(BuildContext context, String amount, String eventId,
//       String eventName) async {
//     try {
//       isLoading.value = true;

//       // Create payment intent first
//       final paymentIntent = await createPaymentIntent(amount, eventId);

//       if (paymentIntent == null) {
//         Get.snackbar(
//           'Error',
//           'Unable to initialize payment',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }

//       // Get the client secret
//       final clientSecret = paymentIntent['client_secret'];

//       // Launch the Stripe Checkout page in a WebView
//       Get.to(() => StripeCheckoutPage(
//             clientSecret: clientSecret,
//             amount: amount,
//             eventName: eventName,
//             onSuccess: () {
//               Get.back(); // Close the WebView
//               Get.snackbar(
//                 'Success',
//                 'Payment completed successfully',
//                 backgroundColor: Colors.green,
//                 colorText: Colors.white,
//               );
//               // Here you can add code to store the ticket in your database
//             },
//             onError: (error) {
//               Get.back(); // Close the WebView
//               Get.snackbar(
//                 'Error',
//                 'Payment failed: $error',
//                 backgroundColor: Colors.red,
//                 colorText: Colors.white,
//               );
//             },
//           ));
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'An error occurred: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// class StripeCheckoutPage extends StatefulWidget {
//   final String clientSecret;
//   final String amount;
//   final String eventName;
//   final Function onSuccess;
//   final Function(String) onError;

//   const StripeCheckoutPage({
//     Key? key,
//     required this.clientSecret,
//     required this.amount,
//     required this.eventName,
//     required this.onSuccess,
//     required this.onError,
//   }) : super(key: key);

//   @override
//   State<StripeCheckoutPage> createState() => _StripeCheckoutPageState();
// }

// class _StripeCheckoutPageState extends State<StripeCheckoutPage> {
//   late WebViewController controller;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     // Create a WebViewController
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             setState(() {
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });

//             // Check for success or failure URLs
//             if (url.contains('success')) {
//               widget.onSuccess();
//             } else if (url.contains('cancel')) {
//               widget.onError('Payment was canceled');
//             }
//           },
//           onWebResourceError: (WebResourceError error) {
//             widget.onError('Error loading payment page: ${error.description}');
//           },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse('https://checkout.stripe.com/pay/${widget.clientSecret}'),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pay \$${widget.amount} - ${widget.eventName}'),
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () {
//             widget.onError('Payment was canceled');
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: controller),
//           if (isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
