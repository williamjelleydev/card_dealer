import 'package:card_dealer/Services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:card_dealer/Constants/MyColors.dart';

class SharedWidgets {

  Widget appBar(String title, ColorService colorService) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: colorService.getTitleText(),
          fontSize: 30.0,
        ),
      ),
      backgroundColor: colorService.titleBackGround,
    );
  }

}