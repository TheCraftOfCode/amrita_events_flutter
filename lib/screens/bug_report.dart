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
        recipients: ["nirmalkarthikeyan1503@gmail.com"],
        //TODO: Change
        isHTML: false,
      );

      FlutterEmailSender.send(email)
          .then((value) => clearFieldContent())
          .catchError((e) {
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
                  const TopBarWidgetWithBackButton(title: 'Report a Bug',icon: Icons.arrow_back_ios_outlined,),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: colors.scaffoldColor,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: _nameController,
                                        style: GoogleFonts.montserrat(
                                            color: colors.primaryTextColor),
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            return "Please enter your name";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text('Name',
                                              style: GoogleFonts.raleway(
                                                  color:
                                                  colors.textBoxTextColor,
                                                  fontSize: 15)),
                                          filled: true,
                                          hintText: 'Enter your name',
                                          hintStyle: GoogleFonts.poppins(
                                              color: colors.primaryTextColor
                                                  .withOpacity(0.7)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          fillColor: colors.textBoxColor,
                                          focusColor: colors.textBoxColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: _queryController,
                                        style: GoogleFonts.montserrat(
                                            color: colors.primaryTextColor),
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            return "Please explain the bug you faced";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text('Bug',
                                              style: GoogleFonts.raleway(
                                                  color:
                                                  colors.textBoxTextColor,
                                                  fontSize: 15)),
                                          filled: true,
                                          hintText: 'Enter your query',
                                          hintStyle: GoogleFonts.poppins(
                                              color: colors.primaryTextColor
                                                  .withOpacity(0.7)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          fillColor: colors.textBoxColor,
                                          focusColor: colors.textBoxColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                  Expanded(child: contactCard(digitalContentTeam[0])),
                  Expanded(child: contactCard(digitalContentTeam[1])),
                  Expanded(child: contactCard(digitalContentTeam[2])),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          await launch("mailto:nirmalkarthikeyan1503@gmail.com");
                        },
                        child: Text(
                          'Official Mail ID: nirmalkarthikeyan1503@gmail.com',
                          //TODO: Replace
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
