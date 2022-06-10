import 'package:amrita_events_flutter/screens/events_home.dart';
import 'package:amrita_events_flutter/screens/password_recovery_page.dart';
import 'package:amrita_events_flutter/screens/sign_up_page.dart';
import 'package:amrita_events_flutter/screens/the_main.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/left_beveled_container.dart';
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/password_formfield_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: LeftBeveledContainer(columnList: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome',
              style: GoogleFonts.nunitoSans(
                  color: colors.primaryTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Login',
              style: GoogleFonts.nunitoSans(
                  color: colors.primaryTextColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 50),
          child: TextBoxField(
            validator: (value) {},
            padding: const EdgeInsets.only(bottom: 5),
            title: 'Email',
            hint: 'Please enter your e-mail',
            light: true,
          ),
        ),
        const PasswordFormFieldWidget(
            label: 'Password', hintText: 'Enter password here'),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage()));
                },
                child: Text(
                  'Sign up instead',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.primaryTextColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PasswordRecovery()));
                },
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.primaryTextColor),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: colors.accentColor,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: colors.primaryTextColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TheMain()));
              },
              child: Text(
                'SIGN IN',
                style: GoogleFonts.nunitoSans(
                    color: colors.primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(primary: colors.accentColor),
            )
          ],
        )
      ]),
    );
  }
}
