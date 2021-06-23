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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/${cardProvider.getBackCard()}"),
                      )
                  ),
                ),
                new Center(
                    child: Padding(
                      // Makes buttons appear subtly nicer spaced
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button('Deal Cards!', () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => DealPage(cardProvider: cardProvider)));
                          }),
                          button('Customize Deck', () {}),
                          button('Settings', () {}),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  Widget button(String text, VoidCallback onPressed) {
    // TODO: make sure these buttons are all the same size (width) somehow..
    return ElevatedButton(
      // TODO: redirect to DealPage
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35.0,
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