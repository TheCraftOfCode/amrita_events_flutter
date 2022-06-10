import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';


class TopBarWithTextWidget extends StatefulWidget {
  const TopBarWithTextWidget({Key? key, required this.title, required this.text}) : super(key: key);

  final String title;
  final String text;

  @override
  State<TopBarWithTextWidget> createState() => _TopBarWithTextWidgetState();
}

class _TopBarWithTextWidgetState extends State<TopBarWithTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: constants.rightBeveledRectangle, color: colors.cardColor),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded, size: 30),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: AutoSizeText(
                              widget.title,
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold,
                                  color: colors.primaryTextColor,),
                              maxFontSize: 40,
                              maxLines: 2,
                              minFontSize: 28,
                            ),
                          ),
                         SizedBox(
                           width: MediaQuery.of(context).size.width*0.7,
                           child: AutoSizeText(widget.text,style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.normal,
                                color: colors.primaryTextColor,
                                fontSize: 15),maxLines: 3,minFontSize: 15,),
                         )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
