import 'dart:convert';

import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/network_image.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key, required this.model, required this.rsvp})
      : super(key: key);

  final EventModel model;
  final void Function(EventModel) rsvp;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      makePostRequest(json.encode({"id": widget.model.id}), "/event/pageViewed",
          null, true, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          TopBarWidgetWithBackButton(
              title: widget.model.title, icon: Icons.arrow_back_ios_rounded),
          Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 15, right: 15, bottom: 30),
              child: SizedBox(
                height: 500,
                child: networkImage(widget.model.posterUrl),
              )),
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'HOST: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 18),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.host,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 18),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'VENUE: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 18),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.location,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 18),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'TYPE: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 18),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.eventType,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 18),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'DATE: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 18),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.date,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 18),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'TIME: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 18),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.time,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 18),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              widget.model.description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.nunitoSans(
                  fontSize: 23, color: colors.headingTextColor),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: !widget.model.rsvp
                    ? () {
                        setState(() {
                          widget.rsvp(widget.model);
                        });
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Center(
                      child: Text(
                        widget.model.rsvp ? 'Already RSVPd' : 'RSVP',
                        style: GoogleFonts.nunitoSans(
                            color: widget.model.rsvp
                                ? Colors.white38
                                : colors.scaffoldColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: colors.accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
