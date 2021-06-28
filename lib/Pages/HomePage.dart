import 'package:card_dealer/Constants/MyColors.dart';
import 'package:card_dealer/Pages/CustomizeDeckPage.dart';
import 'package:card_dealer/Pages/DealPage.dart';
import 'package:card_dealer/Pages/SettingsPage.dart';
import 'package:card_dealer/Services/CardProvider.dart';
import 'package:card_dealer/Services/ColorService.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO:
  // You need to make sure you set the state when you pop the SettingsPage off and return!
  // Rememer that this _might_ have affedted the homepage so needs to be rebuilt

  // I don't _actually_ get this whole final thing tbh..
  final CardProvider cardProvider = CardProvider();
  final ColorService colorService = ColorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedWidgets().appBar('Card Dealer', colorService),
        backgroundColor: colorService.background,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/${cardProvider.getBackCard()}"),
                      )
                  ),
                ),
                new Center(
                    child: Padding(
                      // Makes buttons appear subtly nicer spaced
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button('Deal Cards!', () {
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => DealPage(cardProvider: cardProvider, colorService: colorService)));
                          }),
                          button('Customize Deck', () {
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => CustomizeDeckPage(cardProvider: cardProvider, colorService: colorService,)));
                          }),
                          button('Settings', () {
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => SettingsPage(colorService: colorService)));
                          }),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  Widget button(String text, VoidCallback onPressed) {
    // TODO: make sure these buttons are all the same size (width) somehow..
    return ElevatedButton(
      // TODO: redirect to DealPage
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35.0,
            color: colorService.text
            )
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => colorService.button),
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