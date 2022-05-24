import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: constants.rightBeveledRectangle, color: colors.cardColor),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 40,
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 45,
                        fontWeight: FontWeight.normal,
                        color: colors.primaryTextColor),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextBoxField(
                      hint: 'Type to search',
                      light: true,
                      validator: (val) {},
                      padding: const EdgeInsets.only(top: 10),
                      title: 'Search',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Material(
                      color: colors.scaffoldColor,
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.search_outlined,
                          color: colors.headingTextColor,
                        ),
                      ),
                    ),
                    onTap: (){
                      //TODO: Write search function here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
