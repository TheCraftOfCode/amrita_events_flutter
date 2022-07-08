import 'dart:convert';

import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/dropdown_widget.dart';
import 'package:amrita_events_flutter/widgets/error_box.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final List<String> _roles = ['admin', 'super_admin', 'user'];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String error = "";
  bool showProgress = false;
  var roleData = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await displayQuitDialog(
            context, "Close Page?", "Are you sure you want to close this page? All data will be lost");
      },
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Form(
              key: _formKey,
              child: CustomSliverView(
                columnList: [
                  Container(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Add user',
                          style: GoogleFonts.nunito(
                              fontSize: 30,
                              color: colors.primaryTextColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: constants.textFieldPadding,
                    child: DropDownFormField(
                      list: _roles,
                      title: 'Pick role',
                      hint: 'Pick an appropriate role',
                      onSaved: (data) {
                        roleData = data;
                      },
                    ),
                  ),
                  Padding(
                    padding: constants.textFieldPadding,
                    child: TextFormField(
                        controller: _nameController,
                        style: GoogleFonts.montserrat(
                            color: colors.primaryTextColor),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Please enter name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('Name',
                              style: GoogleFonts.raleway(
                                  color: colors.textBoxTextColor, fontSize: 12)),
                          filled: true,
                          hintText: 'Please enter your name',
                          hintStyle: GoogleFonts.poppins(
                              color: colors.primaryTextColor.withOpacity(0.7)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                          fillColor: colors.textBoxColor,
                          focusColor: colors.textBoxColor,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                        )),
                  ),
                  Padding(
                    padding: constants.textFieldPadding,
                    child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Please enter E-Mail";
                          } else if (!EmailValidator.validate(value)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                        style: GoogleFonts.montserrat(
                            color: colors.primaryTextColor),
                        decoration: InputDecoration(
                          label: Text('Email',
                              style: GoogleFonts.raleway(
                                  color: colors.textBoxTextColor, fontSize: 12)),
                          filled: true,
                          hintText: 'Please enter your amrita email id',
                          hintStyle: GoogleFonts.poppins(
                              color: colors.primaryTextColor.withOpacity(0.7)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                          fillColor: colors.textBoxColor,
                          focusColor: colors.textBoxColor,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                        )),
                  ),
                  Padding(
                    padding: constants.textFieldPadding,
                    child: error == "" ? Container() : errorBox(error),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: showProgress
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  setState(() {
                                    showProgress = true;
                                  });
                                  // var res = await makePostRequest(
                                  //     json.encode({
                                  //       "name": _nameController.text,
                                  //       "email": _emailController.text,
                                  //       "role": roleData
                                  //     }),
                                  //     "/registerAdminUser",
                                  //     null,
                                  //     true,
                                  //     context: context);
                                  setState(() {
                                    showProgress = false;
                                  });
                                  // if (res.statusCode == 200) {
                                  //   error = '';
                                  //   displayDialog(context, "Continue", null, () {
                                  //     Navigator.of(context).pop();
                                  //     Navigator.of(context).pop();
                                  //   }, "Account has been created",
                                  //       "An account has been created and password has been sent to the mail ID");
                                  // } else {
                                  //   setState(() {
                                  //     error = json.decode(res.body)['message'];
                                  //   });
                                  // }
                                }
                              },
                              child: Text(
                                'CREATE USER',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
