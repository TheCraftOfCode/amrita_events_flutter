import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../widgets/left_beveled_container.dart';
import '../widgets/otp_input_widget.dart';
import '../widgets/top_bar_no_search_widget.dart';
import 'events_home.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(icon: Icons.home_outlined, title: "Password Recovery"),
          Expanded(child: Container()),
          LeftBeveledContainer(
            columnList: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter OTP',
                      style: GoogleFonts.nunitoSans(
                          color: colors.primaryTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please enter the OTP sent to your phone number',
                    style: GoogleFonts.nunitoSans(
                        color: colors.primaryTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OTPInput(_fieldOne, true),
                    OTPInput(_fieldTwo, false),
                    OTPInput(_fieldThree, false),
                    OTPInput(_fieldFour, false)
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't get OTP?",
                      style: GoogleFonts.nunitoSans(
                          color: colors.primaryTextColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Resend",
                          style: GoogleFonts.nunitoSans(
                              color: colors.primaryTextColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Text(
                      'in',
                      style: GoogleFonts.nunitoSans(
                          color: colors.primaryTextColor),
                    ),
                    Text(
                      ' 00:50',
                      style: GoogleFonts.nunitoSans(
                          color: colors.primaryTextColor),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventsHome()));
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Center(
                        child: Text(
                          'VERIFY',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))),
                style: ElevatedButton.styleFrom(primary: colors.scaffoldColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
