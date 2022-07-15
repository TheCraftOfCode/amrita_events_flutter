import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

import '../widgets/custom_sliver_widget.dart';
import '../widgets/textbox_widget.dart';
import 'onboarding.dart';

class RequestFeaturesPage extends StatefulWidget {
  const RequestFeaturesPage({Key? key}) : super(key: key);

  @override
  State<RequestFeaturesPage> createState() => _RequestFeaturesPageState();
}

class _RequestFeaturesPageState extends State<RequestFeaturesPage> {
  final _formKey = GlobalKey<FormState>();
  final _featureController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _commentController = TextEditingController();

  clearFieldContent() {
    _featureController.clear();
    _descriptionController.clear();
    _commentController.clear();
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      body:
          "${_descriptionController.text}\n\n${_commentController.text.isNotEmpty ? "COMMENT:\n" : ""}${_commentController.text.isNotEmpty ? _commentController.text : ""}",
      subject: "Request for feature: ${_featureController.text}",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Form(
        key: _formKey,
        child: CustomSliverView(
          columnList: [
            const TopBarWithTextWidget(
                title: 'Feature Request',
                text:
                    'Think something can improve the app? We’re listening. Please let us know.'),
            TextBoxField(
              controller: _featureController,
              validator: (value) {
                if (value == "" || value == null) {
                  return "Please enter your feature title";
                } else {
                  return null;
                }
              },
              padding: const EdgeInsets.only(
                  bottom: 15, top: 50, left: 20, right: 20),
              title: 'FEATURE',
              hint: 'Please give a short title',
              light: false,
            ),
            SizedBox(
              child: TextBoxField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Please enter your feature description";
                  } else {
                    return null;
                  }
                },
                padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                title: 'DESCRIPTION',
                hint: 'Describe the feature as best as you can',
                light: false,
              ),
            ),
            SizedBox(
              child: TextBoxField(
                controller: _commentController,
                padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                title: 'COMMENTS, IF ANY',
                hint: 'Let us know what you think we should know!',
                light: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendEmail();
                    }
                  },
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        color: colors.scaffoldColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: colors.headingTextColor),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
