import 'dart:convert';

import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';

import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/error_box.dart';
import '../../widgets/left_beveled_container.dart';
import '../../widgets/password_formfield_widget.dart';
import '../../widgets/top_bar_no_search_widget.dart';

class BroadcastNotifications extends StatefulWidget {
  const BroadcastNotifications({Key? key}) : super(key: key);

  @override
  State<BroadcastNotifications> createState() => _BroadcastNotificationsState();
}

class _BroadcastNotificationsState extends State<BroadcastNotifications> {
  final _formKey = GlobalKey<FormState>();
  String error = "", _title = "", _body = "";
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await displayQuitDialog(context, "Close Page?",
            "Are you sure you want to close this page? All data will be lost");
      },
      child: Scaffold(
        backgroundColor: colors.scaffoldColor,
        body: Form(
          key: _formKey,
          child: LeftBeveledContainer(
            columnList: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Broadcast Notifications',
                      style: GoogleFonts.nunitoSans(
                          color: colors.primaryTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Have something that all your dear app users have to know? Broadcast it from here!',
                    style: GoogleFonts.nunitoSans(
                        color: colors.primaryTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: errorBox(error),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextBoxField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Please enter notification title";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                  padding: const EdgeInsets.only(bottom: 5),
                  title: 'Notification Title',
                  hint: 'Enter Title',
                  light: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextBoxField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Please enter notification body";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _body = value!;
                  },
                  padding: const EdgeInsets.only(bottom: 5),
                  title: 'Notification Body',
                  hint: 'Enter body',
                  light: true,
                ),
              ),
              showProgress
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showProgress = true;
                            error = '';
                          });

                          _formKey.currentState!.save();
                          var res = await makePostRequest(
                              json.encode({"title": _title, "body": _body}),
                              "/notification/sendNotification",
                              null,
                              true,
                              context);
                          if (res.statusCode == 200) {
                            error = '';
                            displayDialog(context, "Continue", null, () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }, "Successful",
                                "Notification was broadcast successfully");
                          } else {
                            setState(() {
                              error = json.decode(res.body)['message'];
                            });
                          }

                          setState(() {
                            showProgress = false;
                          });
                        }
                      },
                      child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Center(
                              child: Text(
                            'BROADCAST',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
                      style: ElevatedButton.styleFrom(
                          primary: colors.scaffoldColor),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
