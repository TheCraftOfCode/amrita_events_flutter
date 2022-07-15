import 'package:amrita_events_flutter/screens/sign_up_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({Key? key}) : super(key: key);

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  var text = [
    'Register with your e-mail',
    'One stop shop for all events',
    'RSVP to events',
    'Star your favorites',
    'Get notified of updates'
  ];

  var subText = [
    'Usernames are old fashioned. Use your E-mail to sign up and login',
    'No more searching in WhatsApp to find that event you were interested in. Find it all in the app',
    'No more fiddling with forms. Let the organisers know you\'re coming! Get notifications when events are about to start',
    'Star your favorite events and get to them sooner!',
    'Change of venue? Not to fear, updates can now be shared through the app!',
  ];

  var image_location = [
    'assets/svg/screen1.svg',
    'assets/svg/screen2.svg',
    'assets/svg/screen3.svg',
    'assets/svg/screen4.svg',
    'assets/svg/screen5.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      5,
      (index) => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SvgPicture.asset(
                    image_location[index],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text[index],
                      style: GoogleFonts.nunitoSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: colors.headingTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subText[index],
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: colors.headingTextColor),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          )),
        ),
    );
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Stack(children: [
        const Image(
          image: AssetImage('assets/background_onboarding.png'),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: pages.length,
                    effect: WormEffect(
                      activeDotColor: colors.accentColor,
                      dotColor: Color(0xff2E215C),
                      type: WormType.thin,
                      dotHeight: 7,
                      dotWidth: 7,
                    )
                  //   effect: JumpingDotEffect(
                  //       dotHeight: 7,
                  //       dotWidth: 7,
                  //       strokeWidth: 5,
                  //       jumpScale: .7,
                  //       verticalOffset: 5,
                  //       dotColor: const Color(0xff2E215C),
                  //       activeDotColor: colors.accentColor),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const SignUpPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: colors.alternateButtonTextColor),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colors.alternateButtonColor),
                      )),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
