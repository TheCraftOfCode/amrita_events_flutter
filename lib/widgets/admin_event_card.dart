import 'dart:convert';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event_model.dart';
import '../utils/http_modules.dart';
import 'alert_dialog.dart';
import 'network_image.dart';

class AdminStarCard extends StatelessWidget {
  const AdminStarCard(
      {Key? key,
      required this.model,
      required this.removeItem,
      required this.index})
      : super(key: key);

  final EventModel model;
  final Function(EventModel) removeItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Navigate to edit event page
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          color: colors.cardBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  width: double.maxFinite,
                  child: networkImage(model.posterUrl),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      model.title,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colors.headingTextColor),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          model.time,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                        Text(
                          model.date,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        displayDialog(context, "Yes", "No", () async {
                          Navigator.of(context).pop();
                          final response = await makePostRequest(
                              json.encode({"id": model.id}),
                              "/event/deleteEvent",
                              null,
                              true,
                              context);
                          if (response.statusCode == 200) {
                            removeItem(model);
                            // showToast(
                            //     "Deleted user Successfully! Refresh in case if changes have not been reflected");
                          }
                        }, "Delete event",
                            "Are you sure you want to delete this event?");
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
