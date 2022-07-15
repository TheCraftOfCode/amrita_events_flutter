import 'package:amrita_events_flutter/screens/onboarding.dart';
import 'package:amrita_events_flutter/screens/sign_in_page.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
        body: Stack(children: [
          const Image(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomSliverView(
              columnList: [
                Expanded(
                  child: Container(),
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1, bottom: 10),
                  child: Text(
                    "Never miss an event ever again.",
                    style: GoogleFonts.raleway(
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                        color: colors.headingTextColor),
                  ),
                ),
                Text(
                  'Get notified, RSVP to and keep track of events hosted by your favourite clubs.',
                  style: GoogleFonts.nunitoSans(
                      color: colors.headingTextColor, fontSize: 20),
                ),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            color: colors.alternateButtonTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: colors.alternateButtonColor),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FeaturesPage()));
                      },
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            color: colors.scaffoldColor,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: colors.headingTextColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
    );
  }
}
