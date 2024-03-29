import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../widgets/star_card_skeleton_widget.dart';

class Starred extends StatefulWidget {
  const Starred(
      {Key? key,
      required this.data,
      required this.refresh,
      required this.rsvp,
      required this.star})
      : super(key: key);
  final List<EventModel> data;
  final Function refresh;
  final Function(EventModel) rsvp;
  final Function(EventModel) star;

  @override
  State<Starred> createState() => StarredState();
}

class StarredState extends State<Starred> with AutomaticKeepAliveClientMixin {
  List<EventModel> dataSearch = [];

  bool isLoading = true;

  //list depending on root data
  List<Widget> eventList = [];

  String searchPattern = "";


  buildDataList(search) {
    eventList.clear();
    if (!search) {
      dataSearch.clear();
      dataSearch.addAll(widget.data);
    }
    for (var i in dataSearch) {
      setState(() {
        if (i.starred) {
          eventList.add(StarCard(
            model: i,
            rsvp: widget.rsvp,
            star: widget.star,
          ));
        }
      });
    }
  }

  rebuildSearchData(){
    if(searchPattern.isNotEmpty){
      filterSearchData(searchPattern);
    }
  }

  filterSearchData(value){
    dataSearch.clear();
    if (value != null) {
      if (value.isEmpty) {
        setState(() {
          dataSearch.addAll(widget.data);
        });
      } else {
        setState(() {
          dataSearch = widget.data
              .where((i) => i.title
              .toLowerCase()
              .contains(value.toLowerCase()))
              .toList();
        });
      }
    } else {
      setState(() {
        dataSearch.addAll(widget.data);
      });
    }
    buildDataList(true);
  }

  @override
  void initState() {
    super.initState();
    buildDataList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await widget.refresh();
        },
        child: CustomSliverView(
          columnList: [
            TopBarWidget(
              hasback: false,
              title: "Starred",
              onChanged: (value) {
                searchPattern = value ?? "";
                filterSearchData(value);
              },
            ),
            eventList.isNotEmpty
                ? YesStarredEventsWidget(
                    eventList: eventList,
                  )
                : isLoading
                ? const SkeletonLoadingWidget()
                : const NoStarredEventsWidget()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class YesStarredEventsWidget extends StatelessWidget {
  const YesStarredEventsWidget({Key? key, required this.eventList})
      : super(key: key);
  final List<Widget> eventList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: eventList.reversed.toList(),
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
          padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
          child: Image(
            image: const AssetImage('assets/no_starred.png'),
            height: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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

class SkeletonLoadingWidget extends StatelessWidget {
  const SkeletonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
          StarCardSkeletonWidget(),
        ],
      ),
    );
  }
}
