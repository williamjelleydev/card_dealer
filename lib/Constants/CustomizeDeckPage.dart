import 'package:flutter/material.dart';

class CustomizeDeckPage extends StatefulWidget {
  @override
  _CustomizeDeckPageState createState() => _CustomizeDeckPageState();
}

class _CustomizeDeckPageState extends State<CustomizeDeckPage> {
  // This has to somehow display _all_ of the cards on the screen
  // And you are able to click any card to be able to "remove it" from the deck..
  // I have no idea how I would pass that information onto the deal cards page...
  // _maybe_ I would just have to have the CustomizeDeckPage navigate directly to
  // the DealPage (which makes sense I guess..)
  // And that way, I would have access to the full context of what's going on here...
  // OR - I guess I could create some kind of global CardProvider(), that can be
  // edited to "removeCard" somehow...
  // And have a .getShuffledDeck() method which returns a shuffled version of
  // _only_ the cards that are set as available..?


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
