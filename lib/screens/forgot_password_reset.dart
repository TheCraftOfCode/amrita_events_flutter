import 'dart:convert';

import 'package:amrita_events_flutter/screens/sign_in_page.dart';
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

import '../widgets/alert_dialog.dart';
import '../widgets/error_box.dart';
import '../widgets/left_beveled_container.dart';
import '../widgets/password_formfield_widget.dart';
import '../widgets/textbox_widget.dart';

class ForgotPasswordReset extends StatefulWidget {
  const ForgotPasswordReset({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<ForgotPasswordReset> createState() => _ForgotPasswordResetState();
}

class _ForgotPasswordResetState extends State<ForgotPasswordReset> {
  final _formKey = GlobalKey<FormState>();
  String error = "", _password = "", _passwordRepeat = "", _resetCode = "";
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Form(
        key: _formKey,
        child: LeftBeveledContainer(
          columnList: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.nunitoSans(
                        color: colors.primaryTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Please enter reset code and new password',
                  style: GoogleFonts.nunitoSans(
                      color: colors.primaryTextColor,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: errorBox(error),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PasswordFormFieldWidget(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Please enter reset code";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _resetCode = value!;
                  },
                  label: 'Reset Code',
                  hintText: 'Reset Code'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: (MediaQuery.of(context).size.width - 70) / 2,
                      child: PasswordFormFieldWidget(
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Please enter password";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                          label: 'Password',
                          hintText: 'Password')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width - 70) / 2,
                      child: PasswordFormFieldWidget(
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Please enter password";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _passwordRepeat = value!;
                          },
                          label: 'Retype',
                          hintText: 'Retype'))
                ],
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
                        if (_password != _passwordRepeat) {
                          setState(() {
                            error = "Passwords don't match";
                          });
                        } else {
                          var res = await makePostRequest(
                              json.encode({
                                "email": widget.email,
                                "forgotPasswordCode": _resetCode,
                                "password": _password
                              }),
                              "/user/forgotPasswordVerify",
                              null,
                              false,
                              context);
                          if (res.statusCode == 200) {
                            error = '';
                            displayDialog(context, "Continue", null, () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            }, "Successful",
                                "Your password reset was successful, please sign in with your new password");
                          } else {
                            setState(() {
                              error = json.decode(res.body)['message'];
                            });
                          }
                        }

                        setState(() {
                          showProgress = false;
                        });
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
                  )
          ],
        ),
      ),
    );
  }
}
