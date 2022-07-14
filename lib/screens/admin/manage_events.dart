import 'dart:convert';
import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:amrita_events_flutter/widgets/admin_event_card.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/http_modules.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/top_bar_widget.dart';
import 'add_modify_event.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({Key? key}) : super(key: key);

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  List<EventModel> list = [];
  List<EventModel> listSearch = [];

  List<AdminStarCard> widgetList = [];

  late String chosenOption;
  String searchPattern = "";

  //gets data from the server
  _getData() async {
    list.clear();
    listSearch.clear();
    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventModel.fromJSON(i);
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
    return AdminStarCard(
      model: data,
      index: i,
      removeItem: (model) {
        listSearch.remove(model);
        list.remove(model);
        _buildUserList();
      },
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AddModifyEvent(
                  modifyEvent: true,
                  model: data,
                )));
        _getData();
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
                  title: "Manage Events",
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_chart),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  const AddModifyEvent(modifyEvent: false)));
          _getData();
        },
      ),
    );
  }
}
