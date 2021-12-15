import "package:flutter/material.dart";

const largeTextSize = 26.0;
const mediumTextSize = 22.0;
const smallTextSize = 18.0;

const String fontDefaultName = "Poppins";

const appBarTextTheme = TextStyle(
  fontFamily: fontDefaultName,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
  color: Colors.white,
);

const lightModeHeadingTextStyle = TextStyle(
  fontFamily: fontDefaultName,
  fontWeight: FontWeight.w300,
  fontSize: largeTextSize,
  color: Colors.black,
);

const darkModeHeadingTextStyle = TextStyle(
  fontFamily: fontDefaultName,
  fontWeight: FontWeight.w300,
  fontSize: largeTextSize,
  color: Colors.white,
);

const lightModeSubTitleTextStyle = TextStyle(
  fontFamily: fontDefaultName,
  fontWeight: FontWeight.w300,
  fontSize: smallTextSize,
  color: Colors.black,
);

const darkModeSubTitleTextStyle = TextStyle(
  fontFamily: fontDefaultName,
  fontWeight: FontWeight.w300,
  fontSize: smallTextSize,
  color: Colors.white,
);
