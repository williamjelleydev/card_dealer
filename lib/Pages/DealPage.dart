import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';

class DealPage extends StatefulWidget {
  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  int _currentCardIndex = 0;

  _DealPageState() {
    shuffleCards();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer'),
        backgroundColor: MyColors.poolGreen, // if this even does anything.. lol.
        body: Column(
          children: [
            Padding(
              // TODO: see if we can replace this with mainAxisAlignment or something..?
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
              // TODO: change the homepage so the background image card sits the same!
              child: IconButton(
                icon: Image.asset('assets/${getNextCard()}.jpg'),
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
                // Make buttons round as well!
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
      return 'Red_back';
    }
    var card = cards[_currentCardIndex];
    return card;
  }



  // get the code working, _then_ worry about trying to add the rest in, or
  // shuffle these or whatever
  List<String> cards = [
    '2C', '2D', '2H', '2S'
  ];

  void shuffleCards() {
    // well that was easy lol
    cards.shuffle();
    _currentCardIndex = 0;
  }


  Widget button(String text, double fontSize, VoidCallback onPressed) {
    // TODO: make sure these buttons are all the same size somehow..
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

