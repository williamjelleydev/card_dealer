import 'dart:async';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Services/ColorService.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class DealPage extends StatefulWidget {

  final CardProvider cardProvider;
  final ColorService colorService;

  DealPage({this.cardProvider, this.colorService});

  @override
  _DealPageState createState() => _DealPageState(cardProvider: cardProvider, colorService: colorService);
}

class _DealPageState extends State<DealPage> {
  int _currentCardIndex = 0;
  // Hmm - this will be tacky as, since I would need a _new_ stream for _each_ card..

  StreamController<double> _streamController = StreamController<double>();

  // THis is such shit code, but pretty keen to just get it to work for now..
  List<StreamController> _streamControllers = [];


  // This cardProvider _probably_ doesn't need to be stored on here..
  CardProvider cardProvider;
  List<String> cards;
  final ColorService colorService;

  _DealPageState({this.cardProvider, this.colorService}) {
    cards = cardProvider.getAvailableCards();
    cards.shuffle();
  }

  @override
  Widget build(BuildContext context) {

    // _currentCardIndex = cards.length - 1;

    Stream<double> _stream = _streamController.stream;


    // TODO: this is probably an expensive operation to get these all...
    // You should probably think about how to optimise this so each
    // each swipe might be able to load more or something..?
    List<Widget> allCards  = [];
    allCards.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
              'assets/${cardProvider.getBackCard()}'
          ),
        )
    );
    
    cards.forEach((card) {
      var streamController = new StreamController<double>();
      _streamControllers.add(streamController);
      allCards.add(SwipableCard(
        onSwipeCallback: (thing1, thing2) => _currentCardIndex++,
        swipeControl: streamController.stream,
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
                      _streamControllers[_streamControllers.length - 1 -
                          _currentCardIndex].add(angle);
                    }
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

// TODO: this should probably have it's own file..
class SwipableCard extends StatelessWidget {
  @override

  final String card;
  // TODO: these names need to be more descriptive
  final Stream<double> swipeControl;
  final Function onSwipeCallback;

  SwipableCard({this.card, this.swipeControl, this.onSwipeCallback});

  Widget build(BuildContext context) {
    return build2(context);
  }

  Widget build2(BuildContext context) {
    return Swipable(
      onSwipeEnd: onSwipeCallback,
      swipe: swipeControl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image.asset(card),
      )
    );
  }
}


