import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class TextBoxField extends StatefulWidget {
  TextBoxField(
      {Key? key,
      required this.validator,
      required this.title,
      required this.hint, required this.padding, required this.light})
      : super(key: key);

  final _controller = TextEditingController();
  final String? Function(String?)? validator;
  final String title;
  final String hint;
  final EdgeInsets padding;
  final bool light;

  @override
  State<TextBoxField> createState() => _TextBoxFieldState();
}

class _TextBoxFieldState extends State<TextBoxField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
            controller: widget._controller,
            validator: widget.validator,
            style: GoogleFonts.montserrat(color: colors.primaryTextColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            label: Text(widget.title,
                  style: GoogleFonts.nunito(
                      color: widget.light?colors.lightTextBoxTextColor:colors.textBoxTextColor, fontSize: 17)),
              filled: true,
              hintText: widget.hint,
              hintStyle: GoogleFonts.nunito(color: widget.light?colors.lightTextBoxTextColor:colors.textBoxTextColor),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              fillColor:widget.light?colors.lightTextBoxColor:colors.textBoxColor,
              focusColor: widget.light?colors.lightTextBoxColor:colors.textBoxColor,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
            )),
    );
  }
}
