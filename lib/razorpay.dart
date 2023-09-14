// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../api_services.dart';
import 'package:logger/logger.dart';

class RazorPayIntegration {
  final logger = Logger();

  final Razorpay _razorpay = Razorpay(); //Instance of razor pay
  final razorPayKey = "rzp_test_jjXtP4HC5TfI8U";
  final razorPaySecret = "4gBNGuq0FKG1aaepSXNuLDBp";
  intiateRazorPay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  late String data = "no data";
   _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    logger.d('PaymentSuccessResponse $response');

// setState((){
    // data = response.toString();
return response.toString();
// });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    logger.d('PaymentFailureResponse');
    data = response.toString();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    logger.d('ExternalWalletResponse');
    data = response.toString();
  }

  openSession({required num amount}) {
    createOrder(amount: amount).then((orderId) async{
      logger.d(orderId);
      if (orderId.toString().isNotEmpty) {
        var options = {
          'key': razorPayKey, //Razor pay API Key
          'amount': amount, //in the smallest currency sub-unit.
          'name': 'Gajanand.',
          'order_id': orderId, // Generate order_id using Orders API
          'description':
              'Test', //Order Description to be shown in razor pay page
          'timeout': 600, // in seconds
          'prefill': {
            'contact': '6353464720',
            'email': 'singhbhi337@gmail.com'
          } //contact number and email id of user
        };
        _razorpay.open(options);
    // return data;
      } else {}
    });
  }

  createOrder({
    required num amount,
  }) async {
    final myData = await ApiServices().razorPayApi(amount, "rcp_id_1");
    if (myData["status"] == "success") {
      // print(myData);
      logger.d(myData);
      return myData["body"]["id"];
    } else {
      return "";
    }
  }
}
