import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponce {
  String message;
  bool success;
  StripeTransactionResponce({this.message, this.success});
}

//CHECK: why ({}) this in constructor


class StripeService{

  static String _apiBaseUrl = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${ StripeService._apiBaseUrl}/payment_intents';
  static String _secret = 'sk_test_51Grs8VG96JtM6geOWWK2mHEOcGmhxC6L0q7yLYbagQ5X8WlMdUb0mQXeKRYQ5ylzmdpBEWb681dSxcndGaDUdxU900VZxqyHnT';
  static Map<String, String> headers ={
    'Authorization' : 'Bearer ${StripeService._secret}',
    'Content-Type' : 'application/x-www-form-urlencoded'
  };
  static init(){
    StripePayment.setOptions(
        StripeOptions(
          publishableKey: "pk_test_51Grs8VG96JtM6geOzugRJfaHPLG5rvN6FCcgkGsQgyaaoC0uUEu6EiROCbkO3lpsiiucs5P6XT3F029yIyZrv94E00qcjR5EUV",
          merchantId: "Test",
          androidPayMode: 'test'
        ),
      );
  }

  static Future<StripeTransactionResponce> payViaExistingCard({String amount, String currency, CreditCard card}) async
  {
    try{
      var paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );

      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);

     var response =   await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
        )
      );

      if(response.status == 'succeeded'){
        return  StripeTransactionResponce(
        message : 'transaction Successful',
        success:true );
      }else{
        return  StripeTransactionResponce(
        message : 'transaction Successful',
        success:true );
      }

    }catch(e){

      return  StripeTransactionResponce(
      message : 'transaction Failed',
      success:false );
    }


    return  StripeTransactionResponce(
      message : 'transaction Successful',
      success:true );
  }

  static  Future<StripeTransactionResponce> payWithNewCard({String amount, String currency})  async{
    
    try{
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);

     var response =   await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
        )
      );

      if(response.status == 'succeeded'){
        return  StripeTransactionResponce(
        message : 'transaction Successful',
        success:true );
      }else{
        return  StripeTransactionResponce(
        message : 'transaction Successful',
        success:true );
      }

    }catch(e){

      return  StripeTransactionResponce(
      message : 'transaction Failed',
      success:false );
    }

  }

  static Future<Map<String,dynamic>> createPaymentIntent(String amount, String currency) async {
    try{
      Map<String, dynamic> body ={
        'amount': amount,
        'currency' : currency,
        'payment_method_types[]': 'card'
      };

      var responce = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers
      );

      return jsonDecode(responce.body);
      
    }catch(e)
    {
      print('Error Chaging User : ${e.toString()}');
    }

    return null;
  }
}