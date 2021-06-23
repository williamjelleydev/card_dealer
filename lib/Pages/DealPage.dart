import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';

class DealPage extends StatefulWidget {
  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  int _currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer'),
        backgroundColor: MyColors.poolGreen, // if this even does anything.. lol.
        body: Padding(
          // That's not _bad_ padding to be honest!
          padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
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
        )
    );
  }

  String getNextCard() {
    if (_currentCardIndex >= cards.length - 1) {
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

}

