import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/notifications.dart';
import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/screens/settings_page.dart';
import 'package:amrita_events_flutter/screens/starred_events_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';

class TheMain extends StatefulWidget {
  const TheMain({Key? key}) : super(key: key);

  @override
  State<TheMain> createState() => _TheMainState();
}

class _TheMainState extends State<TheMain> {
  int currentIndex = 0;
  final screens = [
    EventsHome(),
    const Starred(),
    const Profile(),
    const Settings(),
    const Notifications()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              backgroundColor: colors.scaffoldColor,
              icon: const Icon(Icons.play_arrow_outlined),
              label: 'Events'),
          BottomNavigationBarItem(
              backgroundColor: colors.scaffoldColor,
              icon: const Icon(Icons.star_border_sharp),
              label: 'Starred'),
          BottomNavigationBarItem(
              backgroundColor: colors.scaffoldColor,
              icon: const Icon(Icons.tag_faces_outlined),
              label: 'Profile'),
          BottomNavigationBarItem(
              backgroundColor: colors.scaffoldColor,
              icon: const Icon(Icons.settings),
              label: 'Settings'),
          BottomNavigationBarItem(
              backgroundColor: colors.scaffoldColor,
              icon: const Icon(Icons.notifications_none_outlined),
              label: 'Notifications')
        ],
      ),
    );
  }
}
