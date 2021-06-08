import 'package:flutter/material.dart';

// Global app variables

// Global app colors:
// AppBar color
Color appBarColor = Colors.blueGrey.shade900;
// App background color
Color backgroundColor = Colors.blueGrey.shade300;
// Text & Icon color
Color textColor = Colors.black;
// Page navigator button colors
MaterialStateProperty<Color> currentButtonColor =
    MaterialStateProperty.all(Colors.blueGrey.shade500);
MaterialStateProperty<Color> otherButtonsColor =
    MaterialStateProperty.all(Colors.white);
MaterialStateProperty<Color> extremeButtonColor =
    MaterialStateProperty.all(Colors.blueGrey.shade200);
// Card background color
Color cardBackgroundColor = Colors.white;
// Global shadow color
Color shadowColor = Colors.black;
// Black, almost completely transparent
Color blackTransparent = Color.fromRGBO(0, 0, 0, 0.8);

// Scale factors
// For text:
textScaleFactor({var scaleFactor}) {
  double scaledText = scaleFactor * 0.03;
  return scaledText;
}

// Shapes:
// Card border radius
ShapeBorder cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(20.0),
  ),
);
// (Same but with BorderRadius)
BorderRadius cardRadius = BorderRadius.circular(20.0);
// Small container radius
BorderRadius smallRadius = BorderRadius.circular(10.0);

// Global icons:
// Global rating icons (stars)
Widget fullStar = Icon(
  Icons.star,
  color: textColor,
);
Widget emptyStar = Icon(
  Icons.star_outline,
  color: textColor,
);
Widget halfStar = Icon(
  Icons.star_half,
  color: textColor,
);
