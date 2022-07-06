import 'dart:convert';

import 'package:amrita_events_flutter/screens/o_t_p_screen.dart';
import 'package:amrita_events_flutter/screens/sign_in_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/error_box.dart';
import 'package:amrita_events_flutter/widgets/left_beveled_container.dart';
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/http_modules.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/password_formfield_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool showProgress = false;
  String _name = "", _email = "", _password = "", _passwordRepeat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.scaffoldColor,
        body: Form(
          key: _formKey,
          child: LeftBeveledContainer(columnList: [
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
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: errorBox(error),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: TextBoxField(
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Please enter name";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _name = value!;
                },
                padding: const EdgeInsets.only(bottom: 5),
                title: 'Name',
                hint: 'Please enter your name',
                light: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
                light: true,
              ),
            ),
            Row(
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignInPage()));
                  },
                  child: Text(
                    'Sign in instead',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.primaryTextColor),
                  ),
                ),
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
                showProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              showProgress = true;
                              error = '';
                            });

                            if (_password != _passwordRepeat) {
                              setState(() {
                                error = "Passwords don't match";
                              });
                            } else {
                              var res = await makePostRequest(
                                  json.encode({
                                    "email": _email,
                                    "password": _password,
                                    "name": _name
                                  }),
                                  "/user/register",
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
                                }, "Account has been registered",
                                    "Please check your mail and open the verification link within the next 15 minutes to complete registration\n\n(Check your Junk Mail/Spam if you haven't received it yet)");
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
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => OTPScreen()));
                        },
                        child: Text(
                          'SIGN UP',
                          style: GoogleFonts.nunitoSans(
                              color: colors.primaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: colors.accentColor),
                      )
              ],
            )
          ]),
        ));
  }
}
