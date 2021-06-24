import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomizeDeckPage extends StatefulWidget {

  final CardProvider cardProvider;

  CustomizeDeckPage({this.cardProvider});

  @override
  _CustomizeDeckPageState createState() => _CustomizeDeckPageState(cardProvider: cardProvider);
}

class _CustomizeDeckPageState extends State<CustomizeDeckPage> {
  CardProvider cardProvider;

  List<String> allCards;
  int currentCardIndex = 0;

  _CustomizeDeckPageState({this.cardProvider}) {
    // TODO: we really want a list of all _ordered_ cards here
    allCards = cardProvider.getAvailableCards();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: SharedWidgets().appBar('Customize Deck'),
      backgroundColor: MyColors.poolGreen,
      body: Column(
        children: [
          Wrap(
            spacing: 3.0,
            alignment: WrapAlignment.start,
            children: getCardIconsFromAvailabilityMapping(cardProvider.getSuitMapForSuit('S')),
          ),
          Wrap(
            spacing: 3.0,
            alignment: WrapAlignment.start,
            children: getCardIconsFromAvailabilityMapping(cardProvider.getSuitMapForSuit('C')),
          ),
          Wrap(
            spacing: 3.0,
            alignment: WrapAlignment.start,
            children: getCardIconsFromAvailabilityMapping(cardProvider.getSuitMapForSuit('D')),
          ),
          Wrap(
            spacing: 3.0,
            alignment: WrapAlignment.start,
            children: getCardIconsFromAvailabilityMapping(cardProvider.getSuitMapForSuit('H')),
          ),
        ],
      )
    );
  }

  String getNextCard() {
    // TODO: what the heck this sucks, just do better lol
    // Is this even still in use anymore..?
    return allCards[currentCardIndex++];
  }

  Widget getIconButtonFromCard(String card, bool isAvailable) {

    if (isAvailable) {
      // TODO: I need to figure out how to make sure these are big enough??
      return IconButton(
        constraints: BoxConstraints(minHeight: 70.0, minWidth: 40.0),
        iconSize: 30.0,
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        icon: Image.asset('assets/${card}'),
        onPressed: () {
          // hmmm, setState() will _probably_ do what I want here, but is
          // probably a pretty pricey move to be doing for each press to be honest..
          setState(() {
            cardProvider.setCardUnavailable(card);
          });
        }
      );
    } else {
      return IconButton(
        iconSize: 39.0,
        constraints: BoxConstraints(minHeight: 70.0, minWidth: 40.0),
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        icon: Center(
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset('assets/${card}'),
                // TODO: can probably do a better looking icon (maybe red??) but whatever for now..
                Icon(Icons.not_interested),
              ],
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            cardProvider.setCardAvailable(card);
          });
        });
    }
  }

  List<Widget> getCardIconsFromAvailabilityMapping(Map<String, bool> cards) {
    List<Widget> result = [];

    cards.forEach((card, isAvailable) {
      result.add(getIconButtonFromCard(card, isAvailable));
    });

    return result;
  }
}
