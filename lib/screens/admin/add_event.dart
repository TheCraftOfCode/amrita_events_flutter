import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';
import 'package:amrita_events_flutter/models/event_model.dart';
import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/error_box.dart';
class AddEvent extends StatefulWidget {
  const AddEvent({Key? key, required this.eventUpdate, required this.eventData})
      : super(key: key);
  final bool eventUpdate;
  final EventModel eventData;

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool showProgress = false;

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await displayQuitDialog(context, "Close Page?",
            "Are you sure you want to close this page? All data will be lost");
      },
      child: Scaffold(
        body: Container(
          //decoration: constants.gradientDecoration,
          child: Form(
            key: _formKey,
            child: CustomSliverView(
              columnList: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 70.0, bottom: 20, left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.eventUpdate ? 'Update Event' : 'Add Event',
                        style: GoogleFonts.nunito(
                            fontSize: 30,
                            color: colors.primaryTextColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      //initialValue: widget.eventData.eventName,
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter event name";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                       // widget.eventData.eventName = value!;
                      },
                      decoration: InputDecoration(
                        label: Text('Event Name',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter event name',
                        hintStyle: GoogleFonts.poppins(
                            color: colors.primaryTextColor.withOpacity(0.7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        //fillColor: colors.textBoxFill,
                        //focusColor: colors.textBoxFill,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      )),
                ),
                // Padding(
                //     padding: EdgeInsets.all(10.0),
                //     child: DatePickerWidget(
                //       defaultDate: widget.eventData.eventDate != ""
                //           ? DateFormat("dd/MM/yyyy")
                //           .parse(widget.eventData.eventDate)
                //           : null,
                //       context: context,
                //       onSaved: (value) {
                //         if (value != null) {
                //           widget.eventData.eventDate =
                //               DateFormat('dd/MM/yyyy').format(value);
                //         }
                //       },
                //     )),
                // Padding(
                //     padding: constants.textFieldPadding,
                //     child: TimePickerWidget(
                //         initialValue: widget.eventData.time != ""
                //             ? TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(
                //           widget.eventData.time,
                //         ))
                //             : null,
                //         context: context,
                //         onSaved: (value) {
                //           widget.eventData.time = formatTimeOfDay(value!);
                //         })),
                // Padding(
                //     padding: constants.textFieldPadding,
                //     child: StringListGenerator(
                //         initialValue: widget.eventData.rules,
                //         title: "Rules",
                //         onSaved: (value) {
                //           widget.eventData.rules = value!;
                //         })),
                // Padding(
                //     padding: constants.textFieldPadding,
                //     child: StringListGenerator(
                //         initialValue: widget.eventData.judgingCriteria,
                //         title: "Judgement Criteria",
                //         onSaved: (value) {
                //           widget.eventData.judgingCriteria = value!;
                //         })),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      initialValue: widget.eventData.location,
                      onSaved: (value) {
                       // widget.eventData.location = value!;
                      },
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter event location";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Event Location',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter event location',
                        hintStyle: GoogleFonts.poppins(
                            color: colors.primaryTextColor.withOpacity(0.7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                       // fillColor: colors.textBoxFill,
                        //focusColor: colors.textBoxFill,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      )),
                ),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      // initialValue: widget.eventData.registrationLink,
                      // onSaved: (value) {
                      //   widget.eventData.registrationLink = value!;
                      // },
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter registration URL";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Registration URL',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter registration URL',
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
                      // initialValue: widget.eventData.submissionLink,
                      // onSaved: (value) {
                      //   widget.eventData.submissionLink = value!;
                      // },
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter submission URL";
                        } else {
                          // RegExp regExp = RegExp(constants.urlPattern);
                          // if (!(regExp.hasMatch(value))) {
                          //   return 'Please enter valid url';
                          // }
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Submission URL',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter submission URL',
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
                      // initialValue: widget.eventData.eventPosterURL,
                      // onSaved: (value) {
                      //   widget.eventData.eventPosterURL = value ?? "";
                      // },
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      decoration: InputDecoration(
                        label: Text('Event Poster URL',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter Event Poster URL',
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
                // Padding(
                //   padding: constants.textFieldPadding,
                //   child: DropDownFormField(
                //     defaultValue: widget.eventData.eventType == ""
                //         ? null
                //         : widget.eventData.eventType,
                //     list: eventType,
                //     title: 'Pick Event Type',
                //     hint: 'Pick an appropriate event type',
                //     onSaved: (data) {
                //       widget.eventData.eventType = data ?? "";
                //     },
                //   ),
                // ),
                Padding(
                  padding: constants.textFieldPadding,
                  child: TextFormField(
                      // initialValue: widget.eventData.eventDescription,
                      // onSaved: (value) {
                      //   widget.eventData.eventDescription = value!;
                      // },
                      style: GoogleFonts.montserrat(
                          color: colors.primaryTextColor),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter event description";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Event Description',
                            style: GoogleFonts.raleway(
                                color: colors.textBoxTextColor, fontSize: 12)),
                        filled: true,
                        hintText: 'Enter event description',
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
                  padding:
                  const EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: showProgress
                        ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                        : ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState?.save();
                        if (_formKey.currentState!.validate()) {
                          var res;
                          setState(() {
                            showProgress = true;
                          });
                          // if (!widget.eventUpdate) {
                          //   res = await makePostRequest(
                          //       widget.eventData.toJSON,
                          //       "/addEvent",
                          //       null,
                          //       true,
                          //       context: context);
                          // } else {
                          //   res = await makePostRequest(
                          //       widget.eventData.toJSON,
                          //       "/updateEvent",
                          //       null,
                          //       true,
                          //       context: context);
                          // }
                          setState(() {
                            showProgress = false;
                          });
                          // if (res.statusCode == 200) {
                          //   error = '';
                          //   showToast(widget.eventUpdate
                          //       ? "Event updated successfully"
                          //       : "Event created successfully");
                          //   Navigator.of(context).pop();
                          // } else {
                          //   setState(() {
                          //     error = json.decode(res.body)['message'];
                          //   });
                          // }
                        }
                      },
                      child: Text(
                        widget.eventUpdate
                            ? 'UPDATE EVENT'
                            : 'CREATE EVENT',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}