import 'package:amrita_events_flutter/widgets/admin_user_list.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/constants.dart' as constants;

import 'add_admin.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: role == constants.superAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAdmin()));
                },
                child: const Icon(Icons.person_add_alt_1_sharp),
              )
            : Container(),
        body: const SizedBox(
          height: double.maxFinite,
          child: AdminUserList(),
        ));
  }
}
