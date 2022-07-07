import 'dart:async';
import 'dart:convert';

import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../utils/http_modules.dart';

class Starred extends StatefulWidget {
  const Starred({Key? key}) : super(key: key);

  @override
  State<Starred> createState() => _StarredState();
}

class _StarredState extends State<Starred> with AutomaticKeepAliveClientMixin {
  List<EventModel> data = [];
  List<EventModel> dataSearch = [];

  //list depending on root data
  List<Widget> eventList = [];

  _rebuildData(){
    data.clear();
    eventList.clear();
    for(var i in dataSearch){
      if (i.starred) {
        data.add(i);
        eventList.add(StarCard(
          model: i,
          rsvp: _rsvp,
          star: _starEvent,
        ));
      }
    }
    dataSearch.clear();
    dataSearch.addAll(data);
  }

  _rsvp(EventModel model) async {
    var response = await makePostRequest(
        json.encode({"eventId": model.id}), "/rsvp/rsvp", null, true, context);

    if (response.statusCode == 200) {
      //TODO: Show message for successful RSVP
      model.rsvp = true;

      //updating list to refresh new changed done to the list
      setState(() {
        _rebuildData();
      });
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
        setState(() {
          _rebuildData();
        });
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
        setState(() {
          _rebuildData();
        });
      }
    }
  }

  _getData() async {
    setState(() {
      data.clear();
      dataSearch.clear();
    });

    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventModel.fromJSON(i);
          if (parseData.starred) {
            data.add(parseData);
            dataSearch.add(parseData);
            eventList.add(StarCard(
              model: parseData,
              rsvp: _rsvp,
              star: _starEvent,
            ));
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await _getData();
        },
        child: CustomSliverView(
          columnList: [
            const TopBarWidget(icon: Icons.star_border_sharp, title: "Starred"),
            //TODO: Check for list size here
            true == true
                ? YesStarredEventsWidget(
                    eventList: eventList,
                  )
                : const NoStarredEventsWidget()
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class YesStarredEventsWidget extends StatelessWidget {
  const YesStarredEventsWidget({Key? key, required this.eventList})
      : super(key: key);
  final List<Widget> eventList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: eventList,
    );
  }
}

class NoStarredEventsWidget extends StatelessWidget {
  const NoStarredEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
          child: Image(
            image: const AssetImage('assets/no_starred.png'),
            height: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Center(
              child: Text(
            'Star your favorite events and have them show up here. Have fun!',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: colors.headingTextColor),
          )),
        ),
      ],
    );
  }
}
