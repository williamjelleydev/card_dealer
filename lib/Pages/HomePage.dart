import 'package:card_dealer/Constants/MyColors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child:
          Text(
            'Card Dealer',
            style: TextStyle(
              color: MyColors.text,
            ),
          )
          ),
          backgroundColor: MyColors.appBar,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          // color: Colors.green,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: MyColors.poolGreen,
          ),
          child: Container(
            // color: Colors.redAccent,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // TODO: change this to be the back of a card..
              color: Colors.red,
            ),
            child: Center(
              child: Column(
                children: [
                  spacingBetweenButtons(),
                  // TODO: bigger buttons here somehow..
                  button('Deal!'),
                  spacingBetweenButtons(),
                  button('Customize Deck'),
                  spacingBetweenButtons(),
                  button('Settings'),
                ],
              ),
            ),
          ),
        )
    );
  }

  // TODO: this should really be dynamic spacing for this kind of thing aye..
  Widget spacingBetweenButtons() {
    return SizedBox(height: 110.0);
  }

  Widget button(String text) {
    // TODO: make sure these buttons are all the same size somehow..
    return ElevatedButton(
      // TODO: redirect to DealPage
        onPressed: () {},
        child: Text(
            text,
            style: TextStyle(
              fontSize: 30.0,
            )
        )
    );
  }
}