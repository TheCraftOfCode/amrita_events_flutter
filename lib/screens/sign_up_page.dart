import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/left_beveled_container.dart';
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          Expanded(child: Container()),
          LeftBeveledContainer(columnList: [
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
                  'Sign up',
                  style: GoogleFonts.nunitoSans(
                      color: colors.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              child: TextBoxField(
                validator: (value) {},
                padding: const EdgeInsets.only(bottom: 10),
                title: 'Name',
                hint: 'Please enter your name',
                light: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              child: TextBoxField(
                validator: (value) {},
                padding: const EdgeInsets.only(bottom: 10),
                title: 'Email',
                hint: 'Please enter your e-mail',
                light: true,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    child: TextBoxField(
                      validator: (value) {},
                      padding: const EdgeInsets.only(bottom: 10),
                      title: 'Password',
                      hint: 'Password',
                      light: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    child: TextBoxField(
                      validator: (value) {},
                      padding: const EdgeInsets.only(bottom: 10),
                      title: 'Retype',
                      hint: 'Retype',
                      light: true,
                    ),
                  ),
                ],
              ),
            )
          ])
        ],
      ),
    );
  }
}
