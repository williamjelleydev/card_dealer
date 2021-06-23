import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';

class DealPage extends StatefulWidget {

  CardProvider cardProvider;

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
      return 'Red_back.jpg';
    }
    var card = cards[_currentCardIndex];
    return card;
  }


  // List<String> cards = ['6D.jpg', '6S.jpg', '5H.jpg', '9H.jpg', '7C.jpg', 'AS.jpg',
  //   'AD.jpg', '6C.jpg', '8H.jpg', '7D.jpg', '4H.jpg', '7S.jpg', 'AC.jpg', 'QH.jpg',
  //   'JC.jpg', '10D.jpg', '10S.jpg', 'KS.jpg', 'KD.jpg', '3H.jpg', '2H.jpg', 'JS.jpg',
  //   'JD.jpg', 'KC.jpg', '10C.jpg', '3C.jpg', '2S.jpg', '2D.jpg', 'JH.jpg', 'QC.jpg',
  //   '10H.jpg', 'KH.jpg', '3S.jpg', '3D.jpg', 'QS.jpg', 'QD.jpg', '2C.jpg', '7H.jpg',
  //   '4S.jpg', '4D.jpg', '9C.jpg', '5C.jpg', '8S.jpg', '8D.jpg', '9S.jpg', '9D.jpg',
  //   '4C.jpg', 'AH.jpg', '8C.jpg', '5S.jpg', '6H.jpg', '5D.jpg'];

  void shuffleCards() {
    // well that was easy lol
    cards.shuffle();
    _currentCardIndex = 0;
  }


  // This code is pretty copy-pastad from HomePage, maybe they should be
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

