import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Services/ColorService.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:card_dealer/Shared/SwipeableCard.dart';

class DealPage extends StatefulWidget {

  final CardProvider cardProvider;
  final ColorService colorService;

  DealPage({this.cardProvider, this.colorService});

  @override
  _DealPageState createState() => _DealPageState(cardProvider: cardProvider, colorService: colorService);
}

class _DealPageState extends State<DealPage> {
  // TODO: this whole page is not very performant.
  // Only loading cards as I need them (or asynchronously) would probably solve
  // most of the performance issues.

  int _currentCardIndex = 0;

  CardProvider cardProvider;
  List<String> cards;
  final ColorService colorService;

  _DealPageState({this.cardProvider, this.colorService}) {
    cards = cardProvider.getAvailableCards();
    cards.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> allCards  = [];
    // TODO: stop getting _all_ cards immediately..
    allCards.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
              'assets/${cardProvider.getBackCard()}'
          ),
        )
    );

    // _MAYBE_ this has to be brought out of the build method, so it only happens once..?
    cards.forEach((card) {
      allCards.add(SwipeableCard(
        onSwipeCallback: (thing1, thing2) => _currentCardIndex++,
        card: 'assets/$card'
      ));
    });

    return new Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer', colorService),
        backgroundColor: colorService.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Stack(
                    children: allCards,
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button('Menu', 20.0, () {
                    Navigator.pop(context);
                  }),
                  button('Next Card', 30.0, () {
                    if (_currentCardIndex < cards.length) {
                      // For whatever reason .5 angle means it goes right..
                      var angle = 0.5;
                      // _streamControllers[_streamControllers.length - 1 -
                      //     _currentCardIndex].add(angle);
                      var currentCard = allCards[allCards.length - _currentCardIndex - 1];
                      var currentSwipable = currentCard as SwipeableCard;
                      // TODO: better null checking here
                      currentSwipable.getSwipeController().add(angle);
                    }
                  }),
                  button('Shuffle', 20.0, () {
                    // Hmm - why would this not work..?
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
    }
    var card = cards[_currentCardIndex];
    return card;
  }

  void shuffleCards() {
    // TODO: find better way of making the Shuffle button play nicely with Next Card,
    // that does NOT involve .pushReplacement().

    // cards.shuffle();
    // _currentCardIndex = 0;
    // // _streamControllers = [];

    // as a test I want to try this stackOverflow answer for how to reload a whole page..

    // I mean this _works_ functionally. Is is just kind of shit
    // It means the enitre page is reloaded, which has a weird jump on the screen...
    // Is that _really_ an acceptable user experience..?
    // MAYBE - if I set a loading image of just the background card, then this would be acceptable..?
    // Or just a new page/layer under this... that only has the image, and is never _really_ reachable
    // Because it just immediately pushes you onto _this_ page, or back to the HomePage..?
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => this.widget
      )
    );
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
                color: colorService.text
            )
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) =>
        colorService.button),
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


