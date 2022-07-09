import 'dart:convert';

import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import '../utils/http_modules.dart';
import 'alert_dialog.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {Key? key,
      required this.name,
      required this.role,
      required this.email,
      required this.index,
      required this.removeItem,
      required this.userRole})
      : super(key: key);
  final String name, role, email, userRole;
  final int index;
  final Function(int) removeItem;

  @override
  Widget build(BuildContext context) {
    final deleteIconButton = Expanded(
      flex: 1,
      child: IconButton(
        icon: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
        onPressed: () {
          displayDialog(context, "Yes", "No", () async {
            Navigator.of(context).pop();
            final response = await makePostRequest(
                json.encode({"email": email}),
                "/admin/delete",
                null,
                true,
                context);
            if (response.statusCode == 200) {
              removeItem(index);
              // showToast(
              //     "Deleted user Successfully! Refresh in case if changes have not been reflected");
              //TODO: Update list here
            }
          }, "Delete user", "Are you sure you want to delete this user?");
        },
      ),
    );

    _getDeleteIconButton() {
      if (userRole == superAdmin) {
        if (role == admin) {
          //allowed
          return deleteIconButton;
        } else if (role == user) {
          //allowed
          return deleteIconButton;
        } else {
          //not allowed
          return Container();
        }
      } else if (userRole == admin) {
        if (role == user) {
          //allowed
          return deleteIconButton;
        } else {
          //not allowed
          return Container();
        }
      } else {
        //not allowed
        return Container();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Card(
        color: colors.cardBackgroundColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 2),
                      child: Text(
                        name,
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(('Role: $role'),
                        style: GoogleFonts.nunito(
                            color: colors.textBoxTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(email.toLowerCase(),
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.nunito(
                              color: Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
              _getDeleteIconButton()
            ],
          ),
        ),
      ),
    );
  }
}

//Allowed access rules for deleting users
//Super admin -> admin, user
//Admin -> user
