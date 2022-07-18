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
      required this.hintText,
      this.onSaved,
      this.light})
      : super(key: key);
  final GlobalKey<FormFieldState>? passwordKey;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String label;
  final String hintText;
  final bool? light;

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
      onSaved: widget.onSaved,
      controller: widget.controller,
      validator: widget.validator,
      style: GoogleFonts.montserrat(
          color: widget.light ?? true ? colors.scaffoldColor : colors.primaryTextColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        label: Text(widget.label,
            style: GoogleFonts.nunito(
                color: widget.light ?? true
                    ? colors.lightTextBoxTextColor
                    : colors.textBoxTextColor,
                fontSize: 17)),
        hintText: widget.hintText,
        suffixIcon: Material(
          color: Colors.transparent,
          child: IconButton(
            color:  widget.light ?? true ? colors.scaffoldColor.withOpacity(0.3) : colors.textBoxTextColor,
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
        hintStyle: GoogleFonts.nunito(
            color: widget.light ?? true
                ? colors.lightTextBoxTextColor
                : colors.textBoxTextColor),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
        fillColor:
            widget.light ?? true ? colors.lightTextBoxColor : colors.textBoxColor,
        focusColor:
            widget.light ?? true ? colors.lightTextBoxColor : colors.textBoxColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
