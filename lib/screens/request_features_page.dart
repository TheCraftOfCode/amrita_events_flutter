import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_sliver_widget.dart';
import '../widgets/textbox_widget.dart';
import 'onboarding.dart';

class RequestFeaturesPage extends StatefulWidget {
  const RequestFeaturesPage({Key? key}) : super(key: key);

  @override
  State<RequestFeaturesPage> createState() => _RequestFeaturesPageState();
}

class _RequestFeaturesPageState extends State<RequestFeaturesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWithTextWidget(
              title: 'Feature Request',
              text:
                  'Think something can improve the app? We’re listening. Please let us know.'),
          TextBoxField(
            validator: (value) {},
            padding: const EdgeInsets.only(bottom: 15,top: 50,left: 20,right: 20),
            title: 'FEATURE',
            hint: 'Please give a short title',
            light: false,
          ),
          SizedBox(
            child: TextBoxField(
              validator: (value) {},
              padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
              title: 'DESCRIPTION',
              hint: 'Describe the feature as best as you can',
              light: false,
            ),
          ),
          SizedBox(
            child: TextBoxField(
              validator: (value) {},
              padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
              title: 'COMMENTS, IF ANY',
              hint: 'Let us know what you think we should know!',
              light: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeaturesPage()));
                },
                child: Text(
                  'SUBMIT',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      color: colors.scaffoldColor,
                      fontWeight: FontWeight.bold),
                ),
                style:
                    ElevatedButton.styleFrom(primary: colors.headingTextColor),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
