import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/app/ui/new/new_card.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    locale: Locale('pt', 'BR'),
    defaultTransition: Transition.cupertino,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    // supportedLocales: [Locale('pt')],
    home: NewCardPage(),
  ));
}
