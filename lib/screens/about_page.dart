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
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Text(
                "ABOUT THE APP",
                style: GoogleFonts.raleway(
                    fontSize: 18,
                    color: colors.headingTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Starting out in life as an elective project done by regular club event hosts, the app has gone through several design changes and feature changes over the past year, resulting in what you see today. The developers are supporters of the philosophy that peer-to-peer information exchange is of paramount importance. Workshops, events and competitions hosted in the campus will help foster this and being able to inform everyone about events without flooding chat apps is the ultimate aim.',
              style: GoogleFonts.nunitoSans(
                fontSize: 15,
                color: colors.headingTextColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
              child: Text(
                "ABOUT US",
                style: GoogleFonts.raleway(
                    fontSize: 18,
                    color: colors.headingTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                const Spacer(),
                person("NM Dhanya", "Asst. Prof, AVVP","assets/developer_pictures/dhanya.jpg"),
                const Spacer(),
                person("Nirmal K", "CSE, 4th year","assets/developer_pictures/nirmal.jpg"),
                const Spacer()
              ],
            ),
          ),
          Center(
            child: Row(
              children: [
                const Spacer(),
                person("Soorya S", "CSE, 4th year","assets/developer_pictures/soorya.jpg"),
                const Spacer(),
                person("Sumithra", "CSE, 4th year","assets/developer_pictures/sumi.jpg"),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget person(nam, titl,imageURL) {
  String name = nam;
  String title = titl;
  String image = imageURL;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Image(image: AssetImage(image),fit: BoxFit.fill,),
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

//TODO: Add person tile from Amritotsavam app