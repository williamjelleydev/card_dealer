import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Pages/DealPage.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // I don't _actually_ get this whole final thing tbh..
  final CardProvider cardProvider = CardProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer'),
        backgroundColor: MyColors.poolGreen,
        body: Container(
          padding: EdgeInsets.fromLTRB(30.0, 65.0, 30.0, 65.0),
          // color: Colors.green,
          child: Container(
            // color: Colors.redAccent,
            // padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // TODO: change this to be the back of a card..
              image: DecorationImage(
                image: AssetImage("assets/playing_card_back3.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              // color: Colors.red,
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 35.0, 0.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    spacingBetweenButtons(),
                    // TODO: bigger buttons here somehow..
                    button('Deal Cards!', () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => DealPage(cardProvider: cardProvider)));
                    }),
                    spacingBetweenButtons(),
                    button('Customize Deck', () {}),
                    spacingBetweenButtons(),
                    button('Settings', () {}),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  // TODO: this should really be dynamic spacing for this kind of thing aye..
  Widget spacingBetweenButtons() {
    return SizedBox(height: 110.0);
  }

  Widget widgetInsidePoolBackground(Widget widget) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 65.0, 30.0, 65.0),
      // color: Colors.green,
      decoration: BoxDecoration(
      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
      color: MyColors.poolGreen,
      ),
    child: widget);
  }

  Widget button(String text, VoidCallback onPressed) {
    // TODO: make sure these buttons are all the same size somehow..
    return ElevatedButton(
      // TODO: redirect to DealPage
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30.0,
            color: MyColors.text
            )
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => MyColors.appBar),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((18.0)),
            side: BorderSide(color: Colors.black, width: 3.0),
          )
        ),
      ),
    );
  }
}