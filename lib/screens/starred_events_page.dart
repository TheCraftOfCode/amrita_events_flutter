import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Starred extends StatefulWidget {
  const Starred({Key? key, required this.yesStarred}) : super(key: key);

  final bool yesStarred;
  @override
  State<Starred> createState() => _StarredState();
}

class _StarredState extends State<Starred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidget(icon: Icons.star_border_sharp, title: "Starred"),
          widget.yesStarred==true?const YesStarredEventsWidget():const NoStarredEventsWidget()
        ],
      ),
    );
  }
}

class YesStarredEventsWidget extends StatelessWidget {
  const YesStarredEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StarCard(eventName: "event_name", time: "time", date: "date"),
        StarCard(eventName: "event_name", time: "time", date: "date")
      ],
    );
  }
}


class NoStarredEventsWidget extends StatelessWidget {
  const NoStarredEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
          child: Image(
            image: const AssetImage('assets/no_starred.png'),
            height: MediaQuery.of(context).size.width*0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Center(
              child: Text(
                'Star your favorite events and have them show up here. Have fun!',
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
