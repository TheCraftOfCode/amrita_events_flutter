import 'package:amrita_events_flutter/models/rsvp_model.dart';
import 'package:amrita_events_flutter/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/top_bar_widget.dart';

class RSVPConsole extends StatefulWidget {
  const RSVPConsole({Key? key, required this.model}) : super(key: key);
  final EventRSVPModel model;

  @override
  State<RSVPConsole> createState() => _RSVPConsoleState();
}

//TODO: Add button to download CSV, show RSVP count and Total viewed count
class _RSVPConsoleState extends State<RSVPConsole> {
  List<User> list = [];
  List<User> listSearch = [];

  List<UserTile> widgetList = [];

  List<String> options = ["All Users", user, admin, superAdmin];
  late String chosenOption;

  //builds a list tile for each user
  _buildUserTile(i) {
    return UserTile(
      userModel: listSearch[i],
      index: i,
      removeItem: (User model) {
        list.remove(model);
        listSearch.remove(model);
        _buildUserList();
      },
      userRole: user,
    );
  }

  //builds the actual widget list accordingly (based on options)
  _buildUserList() {
    widgetList.clear();
    for (int i = 0; i < listSearch.length; i++) {
      setState(() {
        if (chosenOption == options[0]) {
          widgetList.add(_buildUserTile(i));
        } else if (listSearch[i].role == options[1] &&
            chosenOption == options[1]) {
          widgetList.add(_buildUserTile(i));
        } else if (listSearch[i].role == options[2] &&
            chosenOption == options[2]) {
          widgetList.add(_buildUserTile(i));
        } else if (listSearch[i].role == options[3] &&
            chosenOption == options[3]) {
          widgetList.add(_buildUserTile(i));
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
              .where((i) => i.name.toLowerCase().contains(value.toLowerCase()))
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

  _getData() {
    list.clear();
    listSearch.clear();
    list.addAll(widget.model.rsvpUsers);
    listSearch.addAll(widget.model.rsvpUsers);
    _buildUserList();
  }

  @override
  void initState() {
    super.initState();
    chosenOption = options[0];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
              TopBarWidget(
                hasback: true,
                title: "RSVP Console",
                onChanged: (value) {
                  filterSearchData(value);
                },
              ),
              dropDown(options, chosenOption, (newValue) {
                chosenOption = newValue;
                _buildUserList();
              }),
            ] +
            widgetList +
            [const Padding(padding: EdgeInsets.only(bottom: 20))],
      ),
    );
  }
}
