import 'dart:convert';

import 'package:amrita_events_flutter/screens/admin/add_users.dart';
import 'package:amrita_events_flutter/utils/constants.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

import '../../models/user_model.dart';
import '../../utils/http_modules.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/user_tile.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key, required this.userRole}) : super(key: key);
  final String userRole;

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List<User> list = [];
  List<User> listSearch = [];

  List<UserTile> widgetList = [];

  List<String> options = ["All Users", user, admin, superAdmin];
  late String chosenOption;
  String searchPattern = "";

  //gets data from the server
  _getData() async {
    list.clear();
    listSearch.clear();
    var response =
        await makePostRequest(null, "/admin/getUsers", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["users"]; //List Data
      for (var i in responseData) {
        var data = User.fromJSON(i);
        list.add(data);
        listSearch.add(data);
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

  //builds a list tile for each user
  _buildUserTile(i) {
    return UserTile(
      name: listSearch[i].name,
      role: listSearch[i].role,
      email: listSearch[i].email,
      index: i,
      removeItem: (index) {
        list.removeAt(i);
        listSearch.removeAt(i);
        _buildUserList();
      },
      userRole: widget.userRole,
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

  @override
  void initState() {
    chosenOption = options[0];
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
                  title: "Manage Users",
                  onChanged: (value) {
                    searchPattern = value ?? "";
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
      ),
      floatingActionButton: widget.userRole == superAdmin
          ? FloatingActionButton(
              child: const Icon(Icons.person_add),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const AddUsers()));
                _getData();
              },
            )
          : Container(),
    );
  }
}
