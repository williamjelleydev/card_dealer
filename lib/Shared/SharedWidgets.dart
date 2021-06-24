import 'package:flutter/material.dart';
import 'package:card_dealer/Constants/MyColors.dart';

class SharedWidgets {

  Widget appBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: MyColors.text,
        ),
      ),
      backgroundColor: MyColors.appBar,
    );
  }

}