import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;

import '../widgets/custom_sliver_widget.dart';

class RequestFeedbackPage extends StatefulWidget {
  const RequestFeedbackPage({Key? key}) : super(key: key);

  @override
  State<RequestFeedbackPage> createState() => _RequestFeedbackPageState();
}

class _RequestFeedbackPageState extends State<RequestFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: const [
          TopBarWithTextWidget(title: 'Feature Request', text: 'Think something can improve the app? We’re listening. Please let us know.')
        ],
      ),
    );
  }
}
