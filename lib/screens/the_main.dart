import 'dart:convert';

import 'package:amrita_events_flutter/screens/admin/admin_console.dart';
import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/notifications_page.dart';
import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/screens/settings_page.dart';
import 'package:amrita_events_flutter/screens/starred_events_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/event_model.dart';
import '../models/notification.dart';
import '../utils/constants.dart';
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

  late WebSocketChannel channel;

  _initChannel() {
    channel = WebSocketChannel.connect(
      Uri.parse(isHTTPS ? "wss" : "ws" '://$networkAddress/websockets'),
    );
    channel.stream.listen(
      (eventData) {
        var res = json.decode(eventData);
        var socketEventType = res['type'];
        var socketData = res['data'];

        if (socketEventType == eventAdd) {
          var parseData = EventModel.fromJSON(socketData);
          data.add(parseData);
        } else if (socketEventType == eventModify) {
          var parseData = EventModel.fromJSON(socketData);
          for (int i = 0; i < data.length; i++) {
            if (data[i].id == parseData.id) {
              data[i] = parseData;
              break;
            }
          }
        } else if (socketEventType == eventDelete) {
          for (int i = 0; i < data.length; i++) {
            if (socketData['_id'] == data[i].id) {
              data.removeAt(i);
              break;
            }
          }
        } else if (socketEventType == notification) {
          if (_notificationPageState.currentState != null) {
            _notificationPageState.currentState!
                .addMapData(NotificationModel.fromJSON(socketData));
            _notificationPageState.currentState!.buildList();
          }
        }
        if (_eventHomeState.currentState != null) {
          _eventHomeState.currentState!.buildDataList(false);
          _eventHomeState.currentState!.rebuildSearchData();
        }
        if (_starredEventsState.currentState != null) {
          _starredEventsState.currentState!.buildDataList(false);
          _starredEventsState.currentState!.rebuildSearchData();
        }
      },
      onDone: () {
        debugPrint('socket closed');
        _initChannel(); //if closed you will get it here
      },
      onError: (error) {
        print(error);
        _initChannel();
      },
    );
  }

  _getData() async {
    data.clear();

    //TODO: Maybe display non dismissable loading dialog instead?
    if (_eventHomeState.currentState != null) {
      _eventHomeState.currentState!.isLoading = true;
      _eventHomeState.currentState!.setState(() {});
    }
    if (_starredEventsState.currentState != null) {
      _starredEventsState.currentState!.isLoading = true;
      _starredEventsState.currentState!.setState(() {});
    }

    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (_eventHomeState.currentState != null) {
      _eventHomeState.currentState!.isLoading = false;
      _eventHomeState.currentState!.setState(() {});
    }
    if (_starredEventsState.currentState != null) {
      _starredEventsState.currentState!.isLoading = false;
      _starredEventsState.currentState!.setState(() {});
    }

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventModel.fromJSON(i);
          data.add(parseData);
        });
      }
      if (_eventHomeState.currentState != null) {
        _eventHomeState.currentState!.buildDataList(false);
        _eventHomeState.currentState!.rebuildSearchData();
      }
      if (_starredEventsState.currentState != null) {
        _starredEventsState.currentState!.buildDataList(false);
        _starredEventsState.currentState!.rebuildSearchData();
      }
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
      if (_eventHomeState.currentState != null) {
        _eventHomeState.currentState!.buildDataList(false);
        _eventHomeState.currentState!.rebuildSearchData();
      }
      if (_starredEventsState.currentState != null) {
        _starredEventsState.currentState!.buildDataList(false);
        _starredEventsState.currentState!.rebuildSearchData();
      }
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
        if (_eventHomeState.currentState != null) {
          _eventHomeState.currentState!.buildDataList(false);
          _eventHomeState.currentState!.rebuildSearchData();
        }
        if (_starredEventsState.currentState != null) {
          _starredEventsState.currentState!.buildDataList(false);
          _starredEventsState.currentState!.rebuildSearchData();
        }
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
        if (_eventHomeState.currentState != null) {
          _eventHomeState.currentState!.buildDataList(false);
          _eventHomeState.currentState!.rebuildSearchData();
        }
        if (_starredEventsState.currentState != null) {
          _starredEventsState.currentState!.buildDataList(false);
          _starredEventsState.currentState!.rebuildSearchData();
        }
      }
    }
  }

  final GlobalKey<EventsHomeState> _eventHomeState =
      GlobalKey<EventsHomeState>();
  final GlobalKey<StarredState> _starredEventsState = GlobalKey<StarredState>();

  //Notifications
  final GlobalKey<NotificationsState> _notificationPageState =
      GlobalKey<NotificationsState>();

  @override
  void initState() {
    super.initState();
    _initChannel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserRole,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          backgroundColor: colors.scaffoldColor,
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: [
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
              Notifications(
                key: _notificationPageState,
              ),
              if (snapshot.data == admin || snapshot.data == superAdmin)
                AdminConsole(
                  userRole: snapshot.data,
                ),
              const Settings()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() => currentIndex = index);
              controller.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            selectedItemColor: colors.accentColor,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: false,
            iconSize: 28,
            showSelectedLabels: true,
            selectedLabelStyle:
                GoogleFonts.raleway(fontWeight: FontWeight.w800),
            selectedIconTheme: const IconThemeData(size: 35),
            backgroundColor: colors.scaffoldColor,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: colors.scaffoldColor,
                  icon: const Icon(Icons.home_outlined),
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
                  icon: const Icon(Icons.notifications_outlined),
                  label: 'Notifications'),
              if (snapshot.data == admin || snapshot.data == superAdmin)
                BottomNavigationBarItem(
                    backgroundColor: colors.scaffoldColor,
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: 'Admin'),
              BottomNavigationBarItem(
                  backgroundColor: colors.scaffoldColor,
                  icon: const Icon(Icons.settings_outlined),
                  label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
