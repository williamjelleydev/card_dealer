import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

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
    cards.shuffle();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: this is probably an expensive operation to get these all...
    // You should probably think about how to optimise this so each
    // each swipe might be able to load more or something..?
    List<Widget> swipeableCards  = [];
    cards.forEach((card) {
      swipeableCards.add(SwipableCard(
          card: 'assets/$card'
      ));
    });

    // Hmmm, I will continue with this, and figure out how to lay it out nicely again..
    // But I kind of feel like I should be creating swipable stack with just a single
    // card..?
    // And then once it gets swiped, it then loads the next card or something..?
    // I kind of feel like I should have that card on the back, but maybe not..?
    return new Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer'),
        backgroundColor: MyColors.poolGreen,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Stack(
                    children: swipeableCards,
                  )
              ),
              // TODO: add the buttons in at the bottom
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
          ),
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
        MyColors.button),
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


class SwipableCard extends StatelessWidget {
  @override

  final String card;

  SwipableCard({this.card});

  Widget build(BuildContext context) {
    return build2(context);
  }

  Widget build2(BuildContext context) {
    return Swipable(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image.asset(card),
      )
    );
  }
}


