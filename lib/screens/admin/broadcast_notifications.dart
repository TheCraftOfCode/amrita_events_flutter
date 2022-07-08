import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';

import '../../widgets/error_box.dart';

class BroadcastNotifications extends StatefulWidget {
  const BroadcastNotifications({Key? key}) : super(key: key);

  @override
  State<BroadcastNotifications> createState() => _BroadcastNotificationsState();
}

class _BroadcastNotificationsState extends State<BroadcastNotifications> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String error = "";
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await displayQuitDialog(
            context, "Close Page?", "Are you sure you want to close this page? All data will be lost");
      },
      child: Scaffold(
        body: Container(
          // decoration: constants.gradientDecoration,
          height: double.maxFinite,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, bottom: 20, left: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Broadcast Notifications',
                      style: GoogleFonts.nunito(
                          fontSize: 30,
                          color: colors.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      controller: _titleController,
                      style: GoogleFonts.montserrat(color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter title";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Notification Title',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Please enter notification title',
                        hintStyle: GoogleFonts.poppins(
                            color: colors.primaryTextColor.withOpacity(0.7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        // fillColor: colors.textBoxFill,
                        // focusColor: colors.textBoxFill,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      )),
                ),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      controller: _bodyController,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter body";
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.montserrat(color: colors.primaryTextColor),
                      decoration: InputDecoration(
                        label: Text('Notification Body',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Please enter notification body',
                        hintStyle: GoogleFonts.poppins(
                            color: colors.primaryTextColor.withOpacity(0.7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        // fillColor: colors.textBoxFill,
                        // focusColor: colors.textBoxFill,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      )),
                ),
                Padding(
                  padding: constants.textFieldPadding,
                  child: error == "" ? Container() : errorBox(error),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: showProgress
                        ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                        : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          setState(() {
                            showProgress = true;
                          });
                          // var res = await makePostRequest(
                          //     json.encode({
                          //       "title": _titleController.text,
                          //       "body": _bodyController.text
                          //     }),
                          //     "/notify",
                          //     null,
                          //     true,
                          //     context: context);
                          setState(() {
                            showProgress = false;
                          });
                          // if (res.statusCode == 200) {
                          //   error = '';
                          //   displayDialog(context, "Continue", null, () {
                          //     Navigator.of(context).pop();
                          //     Navigator.of(context).pop();
                          //   }, "Notification has been broadcast",
                          //       "A notification with your title and body has been broadcast to all associated devices");
                          // } else {
                          //   setState(() {
                          //     error = json.decode(res.body)['message'];
                          //   });
                          // }
                        }
                      },
                      child: Text(
                        'BROADCAST NOTIFICATION',
                        style:
                        GoogleFonts.nunito(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}