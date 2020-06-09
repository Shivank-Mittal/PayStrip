import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'payment-service.dart';

class ExistingCardsPage extends StatefulWidget {
  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {

  List cards = [{
    'cardNumber': '4242424242424242',
    'expiryDate': '04/24',
    'cardHolderName': 'Shivank Mittal',
    'cvvCode': '424',
    'showBackView': false,
  }, {
    'cardNumber': '5555555555554444',
    'expiryDate': '04/23',
    'cardHolderName': 'MSD',
    'cvvCode': '123',
    'showBackView': false,
  }];

  payViaExistingCard(BuildContext context, card) async{
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(
      message: 'Processing ...'
    );

    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1])
    );

    var responce = await StripeService.payViaExistingCard( amount: '35600',currency: 'USD',card : stripeCard);

    await dialog.hide();
         Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: !responce.success ? Colors.red : Colors.green,
              content: Text(responce.message),
              duration: new Duration(milliseconds: 1200),),
          ).closed.then((_){
            Navigator.pop(context);
          }
        ) ;
    
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chose existing card'),
      ),
      body : Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index){
            var card = cards[index];
            return InkWell(
              child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  expiryDate: card['expiryDate'], 
                  cardHolderName: card['cardHolderName'],
                  cvvCode: card['cvvCode'],
                  showBackView: false, //true when you want to show cvv(back) view
              ),
              onTap: (){
                payViaExistingCard(context, card);
              },
            );
          },
        ),
      )
    );
  }
}