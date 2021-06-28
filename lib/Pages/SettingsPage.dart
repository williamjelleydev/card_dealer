import 'package:card_dealer/Services/ColorService.dart';
import 'package:card_dealer/Shared/SharedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class SettingsPage extends StatefulWidget {

  final ColorService colorService;
  SettingsPage({this.colorService});

  @override
  _SettingsPageState createState() => _SettingsPageState(colorService: colorService);
}

class _SettingsPageState extends State<SettingsPage> {

  final ColorService colorService;

  _SettingsPageState({this.colorService});

  bool changingColour = false;
  Function onChangeColor;

  Color _currentSelectedColor = Colors.red;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedWidgets().appBar('Settings', colorService),
        backgroundColor: colorService.background,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                  children: [SettingsList(
                    // TODO: decide if this background color is appropriate..
                    backgroundColor: Colors.grey,
                    sections: [
                      SettingsSection(
                        // TODO: surely we can do a better title layout here lol...
                        tiles: [
                          // TODO: could _probably_ make cleaner if I had my own MyColor class, that had a few "extra" details about the color..?
                          colorChangeTile('Background Color', colorService.background, (Color newColor) => colorService.background = newColor),
                          colorChangeTile('Text Color', colorService.text, (Color newColor) => colorService.text = newColor),
                          colorChangeTile('Button Color', colorService.button, (Color newColor) => colorService.button = newColor),
                          // colorChangeTile('Title Text Color', colorService.titleText, (Color newColor) => colorService.titleText = newColor),
                          colorChangeTile('Title Background Color', colorService.titleBackGround, (Color newColor) => colorService.titleBackGround = newColor),
                        ],
                      )
                    ],
                  ),
                    colorPickerHsvWidget(),
                  ]
              ),
            ),
          ),
        )
    );
  }

  Widget colorChangeTile(String displayText, Color colorToChange, Function setNewColorCallback) {
    return SettingsTile(
      title: displayText,
      // TODO: this icon needs a black background in case we choose.. nah don't even woorry lol
      trailing: Icon(
        Icons.circle,
        color: colorToChange,
      ),
      onPressed: (BuildContext context) {
        // TODO: thing obviously
        setState(() {
          changingColour = true;
          _currentSelectedColor = colorToChange;
          // TODO: see if this would just work by passing in the colorToChange as well..?

          // Wait what the heck is going on here...?
          onChangeColor = setNewColorCallback;
        });
      },
    );
  }

  Widget colorPickerHsvWidget() {
    // TODO: I will have to make sure that I have a button below/above this
    // for Confirm Color selection or something...

    if (changingColour) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            // color: Colors.white.withOpacity(90.0),
            decoration: BoxDecoration(
              color: _currentSelectedColor,
            ),
            height: MediaQuery.of(context).size.height * 0.75 ,
            width: MediaQuery.of(context).size.width * 0.85,
            // TODO: deal with the fact that the ColorPicker seems to be fixed size :(
            child: Column(
              children: [
                ColorPicker(
                  color: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _currentSelectedColor = value;
                    });
                  }
                ),
                ElevatedButton(
                  // TODO: I need a cancel, or back button here as well...
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
                  onPressed: () {
                    // TODO:This will have to setState for the colorchange..
                    setState(() {
                      // TODO: This right here will have to change the color via colorService..
                      onChangeColor(_currentSelectedColor);
                      changingColour = false;
                    });
                  },
                  child: Text(
                    // TODO: would be nice if this _was_ also the color that we have selected..
                      'Confirm Color',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Opacity(opacity: 0.0);
  }
}
