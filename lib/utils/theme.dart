import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    // Ici, vous pouvez personnaliser votre thème global
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    // Définir la police par défaut
    fontFamily: 'GoogleSans',

    // Personnaliser d'autres éléments du thème si nécessaire
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans'),
    ),
  );
}
