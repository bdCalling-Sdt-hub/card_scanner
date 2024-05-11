
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  TextEditingController amountController = TextEditingController();


  PaypalCheckoutView buildPaypalCheckout({required BuildContext context, required String amount, required String subscriptionName, required String currency}) {
    amountController.text = "";
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: "AX7OSyIbLHC48oMBuFctYsIwoFEK9XUeuSQqgE3Tk38QDf3X0JFgMXbLvofhf1TyYNoXNO_pwe25wVY0",
      secretKey: "EMd9zW3gl-pV6Eit9b7NhkcK2c5roTQnzAeofpjpQte1Srj9SlttJvPqCsQjOlRbgt9rDgpcvcbBvTrK",
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
          "description": "The payment transaction description.",
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
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        print("onSuccess: ${params["message"]}");
      },
      onError: (error) {
        print("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('cancelled:');
      },
    );
  }
}