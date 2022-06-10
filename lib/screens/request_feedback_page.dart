import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

import 'onboarding.dart';
import '../widgets/custom_sliver_widget.dart';
import '../widgets/textbox_widget.dart';

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
        columnList: [
          TopBarWithTextWidget(title: 'Feature Request', text: 'Think something can improve the app? We’re listening. Please let us know.'),
          Padding(
            padding: const EdgeInsets.only(top: 20,  left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("FEATURE", style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: colors.headingTextColor
              ),),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 20, left: 10, right: 10),
            child: TextBoxField(
              validator: (value) {},
              padding: const EdgeInsets.only(bottom: 5),
              title: '',
              hint: '',
              light: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,  left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("DESCRIPTION", style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: colors.headingTextColor
              ),),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 20, left: 10, right: 10),
            child: SizedBox(

              child: TextBoxField(
                validator: (value) {},
                padding: const EdgeInsets.only(bottom: 5),
                title: '',
                hint: '',
                light: true,
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("COMMENTS.IF ANY", style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: colors.headingTextColor
              ),),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 20, left: 10, right: 10),
            child: SizedBox(

              child: TextBoxField(
                validator: (value) {},
                padding: const EdgeInsets.only(bottom: 5),
                title: '',
                hint: '',
                light: true,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child:
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const FeaturesPage()));
                }, child: Text('SUBMIT',style: GoogleFonts.nunitoSans(fontSize: 15,color: colors.scaffoldColor,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: colors.headingTextColor),),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
