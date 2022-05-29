import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

import '../onboarding.dart';
import '../widgets/custom_sliver_widget.dart';
import '../widgets/textbox_widget.dart';

class LiscencePage extends StatelessWidget {
  const LiscencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          TopBarWithTextWidget(title: 'Liscences', text: ''),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('This app is licensed under the MIT License. The terms of the license are as follows: ', style: GoogleFonts.nunitoSans(
              fontSize: 20,
              color: colors.headingTextColor,

            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('orem ipsum dolor sit amet, consectetur adipiscing elit. Nunc, scelerisque augue cras iaculis elit, tellus quam blandit. Egestas auctor cursus quis habitasse id. Adipiscing vulputate tortor a risus neque volutpat. Id ac leo nec facilisi nullam. Lobortis lectus quam pellentesque sodales sed convallis Id at sed hac donec convallis ultricies nisl fames. Ut egestas morbi viverra dignissim purus egestas bibendum tortor. Sapien, tortor elementum lorem massa. Tortor, vulputate suspendisse posuere nec amet elementum tristique eget semper. Ullamcorper mauris id nisi, nunc cursus commodo. Non tincidunt consequat aliquam aliquam donec. In lacus, placerat placerat elementum. Cursus rhoncus viverra quam magna placerat pulvinar egestas. Dictum ullamcorper velit nunc vel.Morbi elit tristique imperdiet mollis lectus lobortis neque, ipsum. Viverra cras congue elit ac enim. Justo urna vitae ultrices dolor, amet in amet. Sit habitasse gravida amet, volutpat. Hac viverra ipsum nulla eget id at a enim id. Sapien purus varius ut bibendum vulputate varius convallis quisque augue. Pretium ut facilisis id pulvinar vulputate morbi. Orci vel, duis ',
              style: GoogleFonts.nunitoSans(
                fontSize: 15,
                color: colors.headingTextColor
              ),
                ),
          )
        ],
      ),
    );
  }
}
