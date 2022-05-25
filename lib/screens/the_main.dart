import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/notifications.dart';
import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/screens/settings.dart';
import 'package:amrita_events_flutter/screens/starred.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class TheMain extends StatefulWidget {
  const TheMain({Key? key}) : super(key: key);

  @override
  State<TheMain> createState() => _TheMainState();
}

class _TheMainState extends State<TheMain> {
  int currentIndex =0;
  final Screens =[
     EventsHome(),
     Starred(),
    Profile(),
    Settings(),
    Notifications()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
currentIndex: currentIndex,
        onTap: (index)=> setState(()=> currentIndex=index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(

            backgroundColor: colors.scaffoldColor,
              icon: Icon(Icons.play_arrow_outlined), label: 'Events'),
          BottomNavigationBarItem(backgroundColor: colors.scaffoldColor,
              icon: Icon(Icons.star_border_sharp), label: 'Starred'),
          BottomNavigationBarItem(backgroundColor: colors.scaffoldColor,
              icon: Icon(Icons.tag_faces_outlined), label: 'Profile'),
          BottomNavigationBarItem(backgroundColor: colors.scaffoldColor,
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(backgroundColor: colors.scaffoldColor,
              icon: Icon(Icons.notifications_none_outlined),
              label: 'Notifications')
        ],
      ),
    );
  }
}
