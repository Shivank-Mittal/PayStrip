import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponce {
  String message;
  bool success;
  StripeTransactionResponce({this.message, this.success});
}

//CHECK: why ({}) this in constructor


class StripeService{

  static String apiBaseUrl = 'https://api.stripe.com//v1';
  static String secret = '';

  static init(){
    StripePayment.setOptions(
        StripeOptions(
          publishableKey: "pk_test_51Grs8VG96JtM6geOzugRJfaHPLG5rvN6FCcgkGsQgyaaoC0uUEu6EiROCbkO3lpsiiucs5P6XT3F029yIyZrv94E00qcjR5EUV",
          merchantId: "Test",
          androidPayMode: 'test'
        ),
      );
  }

  static StripeTransactionResponce payViaExistingCard({String amount, String currency, card})
  {
    return  StripeTransactionResponce(
      message : 'transaction Successful',
      success:true );
  }

  static  Future<StripeTransactionResponce> payWithNewCard({String amount, String currency})  async{
    
    try{
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      print(paymentMethod);
      return  StripeTransactionResponce(
      message : 'transaction Successful',
      success:true );

    }catch(e){

      return  StripeTransactionResponce(
      message : 'transaction Failed',
      success:false );
    }

  }
}