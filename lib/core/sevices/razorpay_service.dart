import 'package:chatx/config/secret.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay razorpay;

  RazorpayService({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onWallet,
  }) {
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWallet);
  }

  void openCheckout({
    required int amount,
    required String name,
    required String description,
    required String email,
    required String contact,
  }) {
    var options = {
      'key': Secret.testAPIKey,
      'amount': (amount * 100).toInt(),
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
    };

    razorpay.open(options);
  }

  void dispose() {
    razorpay.clear();
  }
}
