import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsHome extends StatefulWidget {
  final bool yesEvents;

  const EventsHome({Key? key, required this.yesEvents}) : super(key: key);

  @override
  _EventsHomeState createState() => _EventsHomeState();
}

class Event {
  final String title;
  final String date;
  final String time;

  Event({required this.title, required this.date, required this.time});
}

class _EventsHomeState extends State<EventsHome> {
  List<Event> data = [
    Event(title: 'Event 1', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 2', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 3', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 4', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 5', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidget(
            icon: Icons.home_outlined,
            title: 'Events',
          ),
          widget.yesEvents == false
              ? const YesEventsWidget()
              : const NoEventsWidget()
        ],
      ),
    );
  }
}

class HorizontalPageView extends StatefulWidget {
  const HorizontalPageView({Key? key}) : super(key: key);

  @override
  State<HorizontalPageView> createState() => _HorizontalPageViewState();
}

//TODO: Add titles and modularize the box inside PageView widget
class _HorizontalPageViewState extends State<HorizontalPageView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280, // card height
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PageView.builder(
          padEnds: false,
          itemCount: 10,
          controller: PageController(viewportFraction: 0.45),
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.minWidth,
                        height: constraints.minWidth,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Card ${i + 1}",
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, top: 8),
                        child: AutoSizeText(
                          "CSE: A survival guide",
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 22,
                          maxLines: 2,
                          minFontSize: 19,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, top: 10),
                        child: AutoSizeText(
                          "March 17, 2022",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          maxFontSize: 20,
                        ),
                      )
                    ],
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }
}

class YesEventsWidget extends StatelessWidget {
  const YesEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HorizontalPageView(),
        HorizontalPageView(),
        StarCard(
          date: 'title',
          time: 'time',
          eventName: 'title',
        ),
        StarCard(
          date: 'title',
          time: 'time',
          eventName: 'title',
        ),
        StarCard(
          date: 'title',
          time: 'time',
          eventName: 'title',
        ),
        StarCard(
          date: 'title',
          time: 'time',
          eventName: 'title',
        ),
        StarCard(
          date: 'title',
          time: 'time',
          eventName: 'title',
        ),
      ],
    );
  }
}

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Image(
            image: const AssetImage('assets/no_events.png'),
            height: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Center(
              child: Text(
            'Amazing events are being planned by amazing people. Please check in later!',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: colors.headingTextColor),
          )),
        ),
      ],
    );
  }
}
