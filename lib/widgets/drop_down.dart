import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

Widget dropDown(listOfOptions, chosenOption, onChanged) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 10, left: 16, right: 16),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<dynamic>(
          dropdownColor: colors.cardBackgroundColor,
          icon: const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              // Add this
              Icons.menu_open, // Add this
              // color: colors.errorColor, // Add this
            ),
          ),
          value: chosenOption,
          isExpanded: true,
          items: listOfOptions.map<DropdownMenuItem>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontWeight: FontWeight.bold
            // decorationColor: colors.errorColor
          ),
        ),
      ),
    ),
  );
}