import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  const PasswordFormFieldWidget(
      {Key? key,
      this.passwordKey,
      this.controller,
      this.style,
      this.validator,
      required this.label,
      required this.hintText})
      : super(key: key);
  final GlobalKey<FormFieldState>? passwordKey;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final String label;
  final String hintText;

  @override
  _PasswordFormFieldWidgetState createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  bool setPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !setPasswordVisible,
      key: widget.passwordKey,
      controller: widget.controller,
      validator: widget.validator,
      style: widget.style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        label: Text(widget.label,
            style: GoogleFonts.nunito(
                color: colors.lightTextBoxTextColor, fontSize: 17)),
        hintText: widget.hintText,
        suffixIcon: Material(
          color: Colors.transparent,
          child: IconButton(
            color: colors.primaryTextColor,
            icon: Icon(
              setPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                setPasswordVisible = !setPasswordVisible;
              });
            },
          ),
        ),
        filled: true,
        hintStyle: GoogleFonts.poppins(color: colors.lightTextBoxTextColor),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
        fillColor: colors.lightTextBoxColor,
        focusColor: colors.lightTextBoxColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
