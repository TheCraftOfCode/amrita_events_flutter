import 'package:amrita_events_flutter/screens/sign_up_page.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class GreetingPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomSliverView(
          columnList: [
            Expanded(child: Container(),flex: 2,),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,bottom: 10),
              child: Text("Here's a random line approximate length",style: GoogleFonts.nunitoSans(fontSize: 40,fontWeight: FontWeight.bold,color: colors.headingTextColor),),
            ),
            Text('A small description of what the app is and what it does.',style: GoogleFonts.nunitoSans(color: colors.headingTextColor,fontSize: 20),),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                  }, child: Text('Sign In',style: GoogleFonts.nunitoSans(fontSize: 15,color: colors.alternateButtonTextColor,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: colors.alternateButtonColor),),
                  const SizedBox(width: 20,),
                  ElevatedButton(onPressed: (){}, child: Text('Get Started',style: GoogleFonts.nunitoSans(fontSize: 15,color: colors.scaffoldColor,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: colors.headingTextColor),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
