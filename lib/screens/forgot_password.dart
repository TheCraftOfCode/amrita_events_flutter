import 'dart:convert';

import 'package:amrita_events_flutter/screens/forgot_password_reset.dart';
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

import '../widgets/error_box.dart';
import '../widgets/left_beveled_container.dart';
import '../widgets/textbox_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String error = "", _email = "";
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: LeftBeveledContainer(
        columnList: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter Email',
                  style: GoogleFonts.nunitoSans(
                      color: colors.primaryTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Please enter the email address to reset password',
                style: GoogleFonts.nunitoSans(
                    color: colors.primaryTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: errorBox(error),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 20,
            ),
            child: Form(
              key: _formKey,
              child: TextBoxField(
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Please enter E-Mail";
                  } else if (!EmailValidator.validate(value)) {
                    return "Invalid Email";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _email = value!;
                },
                padding: const EdgeInsets.only(bottom: 5),
                title: 'Email',
                hint: 'Please enter your e-mail',
                light: false,
              ),
            ),
          ),
          showProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState!.validate();
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showProgress = true;
                        error = '';
                      });

                      _formKey.currentState!.save();
                      var res = await makePostRequest(
                          json.encode({"email": _email}),
                          "/user/forgotPassword",
                          null,
                          false,
                          context);

                      setState(() {
                        showProgress = false;
                      });

                      if (res.statusCode == 200) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ForgotPasswordReset(email: _email);
                        }));
                      } else {
                        setState(() {
                          error = json.decode(res.body)['message'];
                        });
                      }
                    }
                  },
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Center(
                          child: Text(
                        'RESET',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))),
                  style:
                      ElevatedButton.styleFrom(primary: colors.scaffoldColor),
                ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordReset(email: _email)));
                }
              },
              child: Text(
                'Already have reset code?',
                style: GoogleFonts.nunitoSans(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
