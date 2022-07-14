import 'dart:convert';

import 'package:amrita_events_flutter/screens/admin/rsvp_console.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../../models/rsvp_model.dart';
import '../../utils/constants.dart';
import '../../utils/http_modules.dart';
import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/rsvp_star_card.dart';
import '../../widgets/top_bar_widget.dart';

class EventRSVPManagement extends StatefulWidget {
  const EventRSVPManagement({Key? key}) : super(key: key);

  @override
  State<EventRSVPManagement> createState() => _EventRSVPManagementState();
}

class _EventRSVPManagementState extends State<EventRSVPManagement> {
  List<EventRSVPModel> list = [];
  List<EventRSVPModel> listSearch = [];

  List<RSVPStarCard> widgetList = [];

  late String chosenOption;
  String searchPattern = "";

  //gets data from the server
  _getData() async {
    list.clear();
    listSearch.clear();
    var response =
        await makePostRequest(null, "/rsvp/getRSVP", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["event"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventRSVPModel.fromJSON(i);
          list.add(parseData);
          listSearch.add(parseData);
        });
      }

      if (searchPattern.isNotEmpty) {
        //filters data directly
        filterSearchData(searchPattern);
      } else {
        //skips to building data as search is empty
        _buildUserList();
      }
    }
  }

  _buildEventTile(data, i) {
    return RSVPStarCard(
      model: data,
      index: i,
      onTap: () async {
        //TODO: Navigate to RSVP console
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => RSVPConsole(model: data)));
      },
    );
  }

  //builds the actual widget list accordingly (based on options)
  _buildUserList() {
    widgetList.clear();
    for (int i = 0; i < listSearch.length; i++) {
      setState(() {
        var data = listSearch[i];
        if (chosenOption == eventOptions[0]) {
          widgetList.add(_buildEventTile(data, i));
        } else if (data.eventType == eventOptions[1] && chosenOption == eventOptions[1]) {
          widgetList.add(_buildEventTile(data, i));
        } else if (data.eventType == eventOptions[2] && chosenOption == eventOptions[2]) {
          widgetList.add(_buildEventTile(data, i));
        } else if (data.eventType == eventOptions[3] && chosenOption == eventOptions[3]) {
          widgetList.add(_buildEventTile(data, i));
        }
      });
    }
    setState(() {});
  }

  filterSearchData(value) {
    listSearch.clear();
    if (value != null) {
      if (value.isEmpty) {
        setState(() {
          listSearch.addAll(list);
        });
      } else {
        setState(() {
          listSearch = list
              .where((i) => i.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      }
    } else {
      setState(() {
        listSearch.addAll(list);
      });
    }
    //rebuild data
    _buildUserList();
  }

  @override
  void initState() {
    chosenOption = eventOptions[0];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
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
                TopBarWidget(
                  title: "RSVP",
                  onChanged: (value) {
                    searchPattern = value ?? "";
                    filterSearchData(value);
                  },
                ),
                dropDown(eventOptions, chosenOption, (newValue) {
                  chosenOption = newValue;
                  _buildUserList();
                }),
              ] +
              widgetList.reversed.toList() +
              [const Padding(padding: EdgeInsets.only(bottom: 20))],
        ),
      ),
    );
  }
}
