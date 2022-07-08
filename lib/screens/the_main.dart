import 'dart:convert';

import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/notifications_page.dart';
import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/screens/settings_page.dart';
import 'package:amrita_events_flutter/screens/starred_events_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';

import '../models/event_model.dart';
import '../utils/http_modules.dart';

class TheMain extends StatefulWidget {
  const TheMain({Key? key}) : super(key: key);

  @override
  State<TheMain> createState() => _TheMainState();
}

class _TheMainState extends State<TheMain> {
  int currentIndex = 0;
  PageController controller = PageController();
  List<EventModel> data = [];

  _getData() async {
    setState(() {
      data.clear();
    });

    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventModel.fromJSON(i);
          data.add(parseData);
        });
      }
      _eventHomeState.currentState!.buildDataList(false);
      _starredEventsState.currentState!.buildDataList(false);
    }
  }

  _rsvp(EventModel model) async {
    var response = await makePostRequest(
        json.encode({"eventId": model.id}), "/rsvp/rsvp", null, true, context);

    if (response.statusCode == 200) {
      //TODO: Show message for successful RSVP
      model.rsvp = true;

      //updating list to refresh new changed done to the list
      setState(() {});
      _eventHomeState.currentState!.buildDataList(false);
      _starredEventsState.currentState!.buildDataList(false);
    }
  }

  _starEvent(EventModel model) async {
    //already starred
    if (!model.starred) {
      var response = await makePostRequest(json.encode({"eventId": model.id}),
          "/event/starEvent", null, true, context);

      if (response.statusCode == 200) {
        //TODO: Show message for successful RSVP
        model.starred = true;

        //updating list to refresh new changed done to the list
        setState(() {});
        _eventHomeState.currentState!.buildDataList(false);
        _starredEventsState.currentState!.buildDataList(false);
      }
    }

    //not starred
    else {
      var response = await makePostRequest(json.encode({"eventId": model.id}),
          "/event/removeStarredEvent", null, true, context);

      if (response.statusCode == 200) {
        //TODO: Show message for successful RSVP
        model.starred = false;

        //updating list to refresh new changed done to the list
        setState(() {});
        _eventHomeState.currentState!.buildDataList(false);
        _starredEventsState.currentState!.buildDataList(false);
      }
    }
  }

  final GlobalKey<EventsHomeState> _eventHomeState =
      GlobalKey<EventsHomeState>();
  final GlobalKey<StarredState> _starredEventsState = GlobalKey<StarredState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    screens = [
      EventsHome(
        key: _eventHomeState,
        data: data,
        refresh: _getData,
        star: _starEvent,
        rsvp: _rsvp,
      ),
      Starred(
        key: _starredEventsState,
        data: data,
        refresh: _getData,
        star: _starEvent,
        rsvp: _rsvp,
      ),
      const Profile(),
      // const Settings(),
      // const Notifications()
    ];
  }

  late List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Notifications()));
              },
              splashRadius: 20,
              icon: Icon(
                Icons.notifications,
                color: colors.scaffoldColor,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Settings()));
              },
              splashRadius: 20,
              icon: Icon(
                Icons.settings,
                color: colors.scaffoldColor,
              )),
          IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon: Icon(
                Icons.logout,
                color: colors.scaffoldColor,
              )),
        ],
      ),
      // extendBodyBehindAppBar: true,
      backgroundColor: colors.scaffoldColor,
      body: PageView.builder(
        controller: controller,
        itemCount: screens.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (BuildContext context, int index) {
          return screens[index];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        backgroundColor: colors.scaffoldColor,
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
          // BottomNavigationBarItem(
          //     backgroundColor: colors.scaffoldColor,
          //     icon: const Icon(Icons.settings),
          //     label: 'Settings'),
          // BottomNavigationBarItem(
          //     backgroundColor: colors.scaffoldColor,
          //     icon: const Icon(Icons.notifications_none_outlined),
          //     label: 'Notifications')
        ],
      ),
    );
  }
}
