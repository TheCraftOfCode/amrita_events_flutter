import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;

class LeftBeveledContainer extends StatefulWidget {

  final List<Widget> columnList;

  const LeftBeveledContainer({Key? key, required this.columnList}) : super(key: key);

  @override
  _LeftBeveledContainerState createState() => _LeftBeveledContainerState();
}

class _LeftBeveledContainerState extends State<LeftBeveledContainer> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  decoration: ShapeDecoration(
                      shape: constants.beveledRectangle,
                      color: colors.cardColor
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.columnList,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
