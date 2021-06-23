import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';

class DealPage extends StatefulWidget {

  final CardProvider cardProvider;

  DealPage({this.cardProvider});

  @override
  _DealPageState createState() => _DealPageState(cardProvider: cardProvider);
}

class _DealPageState extends State<DealPage> {
  int _currentCardIndex = 0;

  // This cardProvider _probably_ doesn't need to be stored on here..
  CardProvider cardProvider;
  List<String> cards;

  _DealPageState({this.cardProvider}) {
    cards = cardProvider.getAvailableCards();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // The appbar text is not very nicely centered :(
      appBar: SharedWidgets().appBar('Card Dealer'),
      backgroundColor: MyColors.poolGreen, // if this even does anything.. lol.
      body: Column(
        children: [
          Padding(
            // TODO: see if we can replace this with mainAxisAlignment or something..?
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
            // TODO: change the homepage so the background image card sits the same!
            child: IconButton(
              icon: Image.asset('assets/${getNextCard()}'),
              iconSize: 500,
              onPressed: () {
                setState(() {
                  _currentCardIndex++;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // TODO: sensible spacing between stuff
              button('Menu', 20.0, () {
                Navigator.pop(context);
              }),
              button('Next Card', 30.0, () {
                setState(() {
                  _currentCardIndex++;
                });
              }),
              button('Shuffle', 20.0, () {
                setState(() {
                  shuffleCards();
                });
              })
            ],
          )
        ],
      )
    );
  }

  String getNextCard() {
    if (_currentCardIndex >= cards.length) {
      return cardProvider.getBackCard();
      // TODO: Maybe if you then click this one _more_ time it returns you to
      //  the homescreen..?
    }
    var card = cards[_currentCardIndex];
    return card;
  }

  void shuffleCards() {
    // well that was easy lol
    cards.shuffle();
    _currentCardIndex = 0;
  }


  // TODO: This code is pretty copy-pastad from HomePage, maybe they should be
  // added to Shared...?
  Widget button(String text, double fontSize, VoidCallback onPressed) {
    return ElevatedButton(
      // TODO: redirect to DealPage
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
        child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                color: MyColors.text
            )
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) =>
        MyColors.appBar),
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

