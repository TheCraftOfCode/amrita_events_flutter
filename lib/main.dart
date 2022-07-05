import 'package:amrita_events_flutter/screens/greeting_page.dart';
import 'package:amrita_events_flutter/screens/the_main.dart';
import 'package:amrita_events_flutter/widgets/load_valid_page_widget.dart';
import 'package:flutter/material.dart';

//TODO: Add login page for admins (only login)
//TODO: Fix overflows
//TODO: Add admin page


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoadValidPageWidget(GreetingPage(), TheMain()),

  ));
}
