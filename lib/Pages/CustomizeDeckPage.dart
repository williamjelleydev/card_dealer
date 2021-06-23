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
  // TODO: See if Wrap works better than GridView for this..?
  // https://www.youtube.com/watch?v=z5iw2SeFx2M&ab_channel=GoogleDevelopers

  CardProvider cardProvider;

  List<String> allCards;
  int currentCardIndex = 0;

  _CustomizeDeckPageState({this.cardProvider}) {
    // TODO: we really want a list of all _ordered_ cards here
    allCards = cardProvider.getAvailableCards();
  }

  @override
  Widget build(BuildContext context) {
    // This will somehow have to show all cards...

    return new Scaffold(
      appBar: SharedWidgets().appBar('Customize Deck'),
      backgroundColor: MyColors.poolGreen,
      body: GridView.count(
        crossAxisCount: 6,
        children: getAllCardIcons2(),
      ),
    );
  }

  String getNextCard() {
    // TODO: what the heck this sucks, just do better lol
    return allCards[currentCardIndex++];
  }

  List<IconButton> getAllCardIcons() {
    // Looks garbage but help plumb things for now
    List<IconButton> allCardIcons = [
      IconButton(
        // TODO: I wonder if I could put this in a loop or not...?
        // Suuuurely this can be automated right??
        icon: Image.asset('assets/${getNextCard()}'),
        onPressed: () {
          // mark as crossed off somehow onscreen and in cardProvider??
        },
      ),
      IconButton(
        // I wonder if I could put this in a loop or not...?
        icon: Image.asset('assets/${getNextCard()}'),
        onPressed: () {
          // mark as crossed off somehow onscreen and in cardProvider??
        },
      ),
      IconButton(
        // I wonder if I could put this in a loop or not...?
        icon: Image.asset('assets/${getNextCard()}'),
        onPressed: () {
          // mark as crossed off somehow onscreen and in cardProvider??
        },
      ),
    ];

    return allCardIcons;
  }

  IconButton getIconButtonFromCard(String card, bool isAvailable) {

    if (isAvailable) {
      return IconButton(
          icon: Image.asset('assets/${card}'),
          onPressed: () {
            // TODO: mark off as crossed on screen and in cardProvider?
            // hmmm, setState() will _probably_ do what I want here, but is
            // probably a pretty pricey move to be doing for each press to be honest..
            setState(() {
              cardProvider.setCardUnavailable(card);
            });
          }
      );
    } else {
      // TODO: figure out how to overlay a cross on this..
    }
  }

  List<IconButton> getAllCardIcons2() {
    List<IconButton> result = [];
    cardProvider.getAvailableCards().forEach((card) {
      // TODO: the "true" should come from the cardProvider availability..
      result.add(getIconButtonFromCard(card, true));
    });

    return result;
  }
}