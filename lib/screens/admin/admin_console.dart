import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/top_bar_no_search_widget.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(
              icon: Icons.settings_outlined, title: "Admin"),
            Expanded(
              child: Column(
                children: const [
                  Expanded(child: Card(
                    child: Text("TILE"),
                  )),
                  Expanded(child: Card(
                    child: Text("TILE"),
                  )),
                  Expanded(child: Card(
                    child: Text("TILE"),
                  )),
                  Expanded(child: Card(
                    child: Text("TILE"),
                  )),
                ],
              ),
            )
        ],
      ),
    );
  }
}
