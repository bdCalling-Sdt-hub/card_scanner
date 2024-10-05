
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  TextEditingController amountController = TextEditingController();
  Currency? currency;
  setCurrency({required value}){
    currency = value;
    update();
  }


  PaypalCheckoutView buildPaypalCheckout({required BuildContext context, required String amount, required String subscriptionName, required String currency}) {
    if (kDebugMode) {
      print("Currency =============>>>: $currency");
    }
    amountController.text = "";
    return PaypalCheckoutView(
      sandboxMode: false,
      clientId: "AcEibMKTu6hnXcLKndc3EfmJk6z-WG9jLSabAsHyCmvKd_Q70XPSGkfVhM5Fhlu0rBkhBEzqOPAJO6VX",
      secretKey: "ECgmzJKxWfBNQeVf8MKWmacOkXWxdau8YN2o9fVzKHt8HCe_OtBOBev7v3It6Sy6rgD97y70gYKiJz8Y",

      transactions: [
        {
          "amount": {
            "total": amount,
            "currency": currency,
            "details": {
              "subtotal": amount,
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.".tr,
          "item_list": {
            "items": [
              {
                "name": subscriptionName,
                "quantity": 1,
                "price": amount,
                "currency": currency
              },
            ],
          }
        }
      ],
      note: "Contact us for any questions on your order.".tr,
      onSuccess: (Map params) async {
        Get.snackbar("Payment successful".tr, "");
        if (kDebugMode) {
          print("onSuccess =============>>>: ${params["message"]}");
        }
        Navigator.pop(context);
      },
      onError: (error) {
        Get.snackbar("$error. Something went wrong,".tr, "Try again!".tr);
        if (kDebugMode) {
          print("onError =============>>>: $error");
        }
        Navigator.pop(context);
      },
      onCancel: () {
        Get.snackbar("Payment cancelled".tr, "");
        if (kDebugMode) {
          print('cancelled:');
        }
      },
    );
  }
}