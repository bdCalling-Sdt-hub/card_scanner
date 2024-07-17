
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  TextEditingController amountController = TextEditingController();


  PaypalCheckoutView buildPaypalCheckout({required BuildContext context, required String amount, required String subscriptionName, required String currency}) {
    amountController.text = "";
    return PaypalCheckoutView(
      sandboxMode: false,
      clientId: "AfbfMD1avsmsvyF5HxVgPZ2NdMIP7Wr4iuQjnALjXoRRXjapraHJrScKwQ3SG_IrGfCZyCvgMZdhHnyR",
      secretKey: "EIkPn15bzfQDYJGEmDwSBD-rLuQ--E-iOaOy0m8QQ2VHaS-NJDmYTPwrcrrK9l-nRNF1hfLFCHACOxSH",
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
          print("onSuccess: ${params["message"]}");
        }
        Navigator.pop(context);
      },
      onError: (error) {
        Get.snackbar("Something went wrong,".tr, "Try again!".tr);
        if (kDebugMode) {
          print("onError: $error");
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