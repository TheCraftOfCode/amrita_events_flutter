import 'dart:convert';

import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:amrita_events_flutter/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../utils/http_modules.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/error_box.dart';
import '../../widgets/left_beveled_container.dart';
import '../../widgets/textbox_widget.dart';

class AddModifyEvent extends StatefulWidget {
  const AddModifyEvent({Key? key, this.model, required this.modifyEvent})
      : super(key: key);
  final EventModel? model;
  final bool modifyEvent;

  @override
  State<AddModifyEvent> createState() => _AddModifyEventState();
}

class _AddModifyEventState extends State<AddModifyEvent> {
  final _formKey = GlobalKey<FormState>();
  bool showProgress = false;

  String error = "",
      _eventName = "",
      _eventType = "",
      _eventLocation = "",
      _eventHost = "",
      _eventDescription = "",
      _eventPosterUrl = "",
      _eventOver = "";

  DateTime? _eventDate;
  TimeOfDay? _eventTime;

  TimeOfDay? _time12to24(String time) {
    String time = widget.model!.time;
    try {
      List<String> timeSlice = time.split(":");
      int hour = int.parse(timeSlice[0]);
      int minute = int.parse(timeSlice[1]);
      String period = timeSlice[2].split(" ")[1];

      if (period == "AM") {
        return TimeOfDay(hour: hour, minute: minute);
      } else {
        return TimeOfDay(hour: (hour + 12) % 23, minute: minute);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (widget.model != null) {
      var _localTime = DateTime.parse(widget.model!.dateUnparsed).toLocal();
      _eventTime = TimeOfDay(hour: _localTime.hour, minute: _localTime.minute);
    }
    super.initState();
  }

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
                        widget.modifyEvent ? 'Modify Event' : 'Add New Event',
                        style: GoogleFonts.nunitoSans(
                            color: colors.primaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.modifyEvent
                          ? 'Modify events here!'
                          : 'Add new events here!',
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
                    initialValue:
                        widget.model != null ? widget.model?.title : '',
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _eventName = value!;
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
                    defaultValue:
                        widget.model != null ? widget.model?.eventType : null,
                    list: const ["CULTURAL", "TECHNICAL", "SPIRITUAL"],
                    title: "Event Type",
                    hint: "Choose event type",
                    errorField: "Please choose an event type",
                    onSaved: (value) {
                      _eventType = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DatePickerWidget(
                      defaultDate: widget.model != null
                          ? DateTime.parse(widget.model!.dateUnparsed)
                          : null,
                      context: context,
                      onSaved: (data) {
                        _eventDate = data;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TimePickerWidget(
                    initialValue: _eventTime,
                    context: context,
                    onSaved: (data) {
                      _eventTime = data;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextBoxField(
                    initialValue:
                        widget.model != null ? widget.model?.location : '',
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event location";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _eventLocation = value!;
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
                    initialValue:
                        widget.model != null ? widget.model?.host : '',
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event host";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _eventHost = value!;
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
                    initialValue:
                        widget.model != null ? widget.model?.description : '',
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter event description";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _eventDescription = value!;
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
                    initialValue:
                        widget.model != null ? widget.model?.posterUrl : '',
                    onSaved: (value) {
                      _eventPosterUrl = value!;
                    },
                    padding: const EdgeInsets.only(bottom: 5),
                    title: 'Poster Url',
                    hint: 'Enter Poster Url (not mandatory)',
                    light: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropDownFormField(
                    defaultValue: widget.model != null
                        ? ((widget.model!.eventOver) ? "Yes" : "No")
                        : "No",
                    list: const ["Yes", "No"],
                    title: "Event Over",
                    hint: "Choose yes if event over, else choose no",
                    errorField:
                        "Please choose option according to event status",
                    onSaved: (value) {
                      _eventOver = value;
                    },
                  ),
                ),
                showProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showProgress = true;
                              error = '';
                            });

                            _formKey.currentState!.save();
                            var res;
                            if (!widget.modifyEvent) {
                              //add, include id
                              res = await makePostRequest(
                                  json.encode({
                                    "eventName": _eventName,
                                    "timeHour": _eventTime!.hour,
                                    "timeMinute": _eventTime!.minute,
                                    "day": _eventDate!.day,
                                    "month": _eventDate!.month,
                                    "year": _eventDate!.year,
                                    "posterUrl": _eventPosterUrl,
                                    "location": _eventLocation,
                                    "host": _eventHost,
                                    "description": _eventDescription,
                                    "eventType": _eventType
                                  }),
                                  "/event/addEvent",
                                  null,
                                  true,
                                  context);
                            } else {
                              //modify data, just include variables
                              res = await makePostRequest(
                                  json.encode({
                                    "id": widget.model!.id,
                                    "eventName": _eventName,
                                    "timeHour": _eventTime!.hour,
                                    "timeMinute": _eventTime!.minute,
                                    "day": _eventDate!.day,
                                    "month": _eventDate!.month,
                                    "year": _eventDate!.year,
                                    "posterUrl": _eventPosterUrl,
                                    "location": _eventLocation,
                                    "host": _eventHost,
                                    "description": _eventDescription,
                                    "eventType": _eventType,
                                    "eventOver": _eventOver == "Yes"
                                  }),
                                  "/event/modifyEvent",
                                  null,
                                  true,
                                  context);
                            }

                            if (res.statusCode == 200) {
                              error = '';
                              displayDialog(context, "Continue", null, () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                                  "Successful",
                                  widget.modifyEvent
                                      ? "Event modified successfully"
                                      : "New event created successfully");
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
                              widget.modifyEvent
                                  ? 'MODIFY EVENT'
                                  : 'CREATE EVENT',
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
