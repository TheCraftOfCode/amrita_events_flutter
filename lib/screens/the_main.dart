import 'dart:async';

import 'package:amrita_events_flutter/screens/bugreport_page.dart';
import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/license_page.dart';
import 'package:amrita_events_flutter/screens/notifications_page.dart';
import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/screens/request_features_page.dart';
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
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    screens = [
      const EventsHome(
      ),
      const Starred(
      ),
      const Profile(),
      const Settings(),
      const Notifications(
      )
    ];
  }

  late List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: PageView.builder(
        controller: controller,
        onPageChanged: (index){
          setState(() => currentIndex = index);
        },
        itemBuilder: (BuildContext context, int index) { 
        return screens[index];
      },),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
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
