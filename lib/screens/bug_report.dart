import 'package:amrita_events_flutter/utils/data.dart';
import 'package:amrita_events_flutter/widgets/contact_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_back_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/textbox_widget.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _queryController = TextEditingController();

    clearFieldContent() {
      _nameController.clear();
      _queryController.clear();
    }

    Future<void> sendEmail() async {
      final Email email = Email(
        body: _queryController.text,
        subject: "Technical Query/Suggestions from ${_nameController.text}",
        recipients: [
          "events.amritacbe@gmail.com",
          "soorya.s27@gmail.com",
          "nirmalkarthikeyan1503@gmail.com",
          "sumisooriya@gmail.com"
        ],
        isHTML: false,
      );

      FlutterEmailSender.send(email)
          .then((value) => clearFieldContent())
          .catchError((e) {
        print(e);
        showToast("Unable to send your query, please try again later!");
      });
    }

    return Scaffold(
      body: Container(
        color: colors.scaffoldColor,
        height: double.maxFinite,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBarWidgetWithBackButton(
                    title: 'Report a Bug',
                    icon: Icons.arrow_back_ios_outlined,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: colors.scaffoldColor,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBoxField(
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value == "" || value == null) {
                                        return "Please enter your name";
                                      } else {
                                        return null;
                                      }
                                    },
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 20, right: 20, top: 30),
                                    title: 'Name',
                                    hint: 'Enter your name',
                                    light: false,
                                  ),
                                  TextBoxField(
                                    controller: _queryController,
                                    validator: (value) {
                                      if (value == "" || value == null) {
                                        return "Please explain the bug you faced";
                                      } else {
                                        return null;
                                      }
                                    },
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 20, right: 20),
                                    title: 'Bug',
                                    hint: 'Add a description of the bug',
                                    light: false,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            onPrimary: colors.accentColor,
                                            primary: colors.primaryTextColor),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            sendEmail();
                                          }
                                        },
                                        child: Text(
                                          "SEND",
                                          style: GoogleFonts.nunito(
                                              color: colors.buttonColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 23, top: 20),
                    child: Text(
                      'Developed and Maintained by',
                      style: GoogleFonts.nunito(
                          fontSize: 25,
                          color: colors.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: contactCard(devTeam[0])),
                  Expanded(child: contactCard(devTeam[1])),
                  Expanded(child: contactCard(devTeam[2])),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          await launch("events.amritacbe@gmail.com");
                        },
                        child: Text(
                          'Official Mail ID: events.amritacbe@gmail.com',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: colors.primaryTextColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
