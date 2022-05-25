import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../onboarding.dart';

class StarCard extends StatelessWidget {
  const StarCard({Key? key, required this.event_name, required this.time, required this.date});

  final String event_name, time, date;


  @override
  Widget build(BuildContext context) {
    return    Card(
      elevation: 10,
      color: colors.cardBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(color: Colors.white,
              height: 200,),

          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(event_name, style: GoogleFonts.nunitoSans(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: colors.headingTextColor
              ),),
            ),
          ),
          Row(

            children: [
              Column(
                children: [
                  Text(time,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 20,

                        color: colors.headingTextColor
                    ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 2, 0, 0),
                    child: Text(date,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 20,

                          color: colors.headingTextColor
                      ),),
                  ),
                ],
              ),

              Spacer(
                flex: 5,
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FeaturesPage()));
              }, child: Text('RSVP',style: GoogleFonts.nunitoSans(fontSize: 15,color: colors.scaffoldColor,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: colors.headingTextColor),),
              Spacer()
            ],
          )
        ],
      ),
    )   ;
  }
}
