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

  }

  static StripeTransactionResponce payViaExistingCard({String amount, String currency, card})
  {
    return  StripeTransactionResponce(
      message : 'transaction Successful',
      success:true );
  }

  static StripeTransactionResponce payWithNewCard({String amount, String currency}){
     return  StripeTransactionResponce(
      message : 'transaction Successful',
      success:true );
  }
}