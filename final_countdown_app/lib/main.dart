import 'package:final_countdown_app/src/pages/countdown_page.dart';
import 'package:final_countdown_app/src/pages/time_selection_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: TimeSelectionPage.routeName,
      routes: {
        TimeSelectionPage.routeName: (context) => TimeSelectionPage(),
        CountDownPage.routeName: (context) => CountDownPage(),
      },
    );
  }
}
