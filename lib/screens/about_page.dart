import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_sliver_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetWithBackButton(
              icon: Icons.arrow_back, title: "About"),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Text(
                "ABOUT THE APP",
                style: GoogleFonts.nunitoSans(
                    fontSize: 15,
                    color: colors.headingTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ullamcorper sodales sem, a fermentum diam scelerisque in. Duis sit amet nibh a eros varius accumsan. Mauris tincidunt nibh vitae est blandit, non tempus ante posuere. Suspendisse posuere consectetur nunc sed porta. Proin porta, nunc sed faucibus condimentum, ipsum sapien congue ante, sit amet facilisis erat velit at risus. Vestibulum ac blandit tortor. Praesent sit amet rutrum dolor. Integer in est euismod, iaculis nunc ut, venenatis lectus.',
              style: GoogleFonts.nunitoSans(
                fontSize: 15,
                color: colors.headingTextColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: Text(
                "ABOUT US",
                style: GoogleFonts.nunitoSans(
                    fontSize: 15,
                    color: colors.headingTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                const Spacer(),
                person("NM Dhanya", "Asst. Prof, AVVP"),
                const Spacer(),
                person("Nirmal K", "CSE, 4th year"),
                const Spacer()
              ],
            ),
          ),
          Center(
            child: Row(
              children: [
                const Spacer(),
                person("Soorya S", "CSE, 4th year"),
                const Spacer(),
                person("Sumithra", "CSE, 4th year"),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget person(nam, titl) {
  String name = nam;
  String title = titl;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: colors.headingTextColor,
          height: 100,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: GoogleFonts.nunitoSans(
                color: colors.headingTextColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.nunitoSans(
            color: colors.headingTextColor,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
