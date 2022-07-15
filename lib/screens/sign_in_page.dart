import 'dart:convert';

import 'package:amrita_events_flutter/screens/password_recovery_page.dart';
import 'package:amrita_events_flutter/screens/sign_up_page.dart';
import 'package:amrita_events_flutter/screens/the_main.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/error_box.dart';
import 'package:amrita_events_flutter/widgets/left_beveled_container.dart';
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/http_modules.dart';
import '../utils/utils.dart';
import '../widgets/password_formfield_widget.dart';
import '../widgets/white_left_beveled_container.dart';
import 'forgot_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String error = "", _email = "", _password = "";
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Form(
          key: _formKey,
          child: WhiteLeftBeveledContainer(columnList: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome',
                  style: GoogleFonts.nunitoSans(
                      color: colors.scaffoldColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Login',
                  style: GoogleFonts.nunitoSans(
                      color: colors.scaffoldColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: errorBox(error),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 20),
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
            PasswordFormFieldWidget(
              label: 'Password',
              hintText: 'Enter password here',
              validator: (value) {
                if (value == "" || value == null) {
                  return "Please enter password";
                } else {
                  return null;
                }
              },
              style: GoogleFonts.montserrat(),
              onSaved: (value) {
                _password = value!;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                    },
                    child: Text(
                      'Sign up instead',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colors.scaffoldColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                    },
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colors.scaffoldColor),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showProgress = true;
                              error = '';
                            });
                            _formKey.currentState!.save();
                            var res = await makePostRequest(
                                json.encode(
                                    {"email": _email, "password": _password}),
                                "/user/login",
                                null,
                                false,
                                context);
                            setState(() {
                              showProgress = false;
                            });
                            if (res.statusCode == 200) {
                              jwtTokenSet = json.decode(res.body)['token'];
                              setName = json.decode(res.body)['name'];
                              setUserRole = json.decode(res.body)['role'];
                              setDateRegistered =
                                  json.decode(res.body)['dateRegistered'];
                              setEmailID = json.decode(res.body)['email'];
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const TheMain()),
                                  (Route<dynamic> route) => false);
                            } else {
                              setState(() {
                                error = json.decode(res.body)['message'];
                              });
                            }
                          }
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => const TheMain()));
                        },
                        child: Text(
                          'SIGN IN',
                          style: GoogleFonts.nunitoSans(
                              color: colors.primaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: colors.scaffoldColor),
                      )
              ],
            )
          ]),
        ),]
      ),
    );
  }
}
