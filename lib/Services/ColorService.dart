import 'package:flutter/material.dart';

class ColorService {

  // TODO: figure out way to make sure this is only instantiated once..?

  // Initial Colors
  static Color poolGreen = Color(0xFF1D6835);

  static Color appBar = Color(0xFF22452d);

  static Color buttonInitial = Color(0xFF2c8f4b);

  static Color textInitial = Colors.black87;

  static Color titleTextInitial = Colors.white.withOpacity(0.9);



  Color background = poolGreen;

  Color titleBackGround = appBar;

  Color button = buttonInitial;

  Color text = textInitial;

  Color titleText = titleTextInitial;


  Color getTitleText() {
    return titleText;
  }

  Color setTitleText(Color value) {
    titleText = value;
  }


}