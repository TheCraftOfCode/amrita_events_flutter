import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';
import '../../utils/http_modules.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/error_box.dart';
import '../../widgets/left_beveled_container.dart';
import '../../widgets/textbox_widget.dart';

class AddModifyEvent extends StatefulWidget {
  const AddModifyEvent({Key? key}) : super(key: key);

  @override
  State<AddModifyEvent> createState() => _AddModifyEventState();
}

class _AddModifyEventState extends State<AddModifyEvent> {
  final _formKey = GlobalKey<FormState>();
  bool showProgress = false;
  String error = "", _userName = "", _userEmail = "", _userRole = "";

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
                        'Add New Event',
                        style: GoogleFonts.nunitoSans(
                            color: colors.primaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add new events here!',
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
                        return "Please enter event name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Event Name',
                    hint: 'Enter Event Name',
                    light: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropDownFormField(
                    list: const ["CULTURAL", "TECHNICAL", "SPIRITUAL"],
                    title: "Event Type",
                    hint: "Choose event type",
                    errorField: "Please choose an event type",
                    onSaved: (value) {
                      _userRole = value;
                    },
                  ),
                ),
                //TODO: Add time and date pickers
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextBoxField(
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event location";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Event Location',
                    hint: 'Enter Location',
                    light: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextBoxField(
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event host";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Event Host',
                    hint: 'Enter Event Host',
                    light: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextBoxField(
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event description";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Event Description',
                    hint: 'Enter Event Description',
                    light: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextBoxField(
                    onSaved: (value) {
                      _userName = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Poster Url',
                    hint: 'Enter Poster Url (not mandatory)',
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
                                json.encode({
                                  "name": _userName,
                                  "email": _userEmail,
                                  "userType": _userRole
                                }),
                                "/admin/register",
                                null,
                                true,
                                context);
                            if (res.statusCode == 200) {
                              error = '';
                              displayDialog(context, "Continue", null, () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }, "Successful",
                                  "New user created successfully, access credentials has been sent to their mail box");
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
                              'REGISTER USER',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ))),
                        style: ElevatedButton.styleFrom(
                            primary: colors.scaffoldColor),
                      )
              ],
            ),
          ),
        ));
  }
}
