import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

displayDialog(context, positiveText, negativeText, Function positiveFunction,
    title, subTitle,
    {dismissDialog, willPop}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissDialog ?? true,
    builder: (context) => WillPopScope(
      onWillPop: () async => willPop ?? true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: colors.cardBackgroundColor,
        title: Text(
          title,
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold, color: colors.headingTextColor),
        ),
        content: Text(
          subTitle,
          style: GoogleFonts.raleway(
              color: colors.headingTextColor.withOpacity(0.8)),
        ),
        actions: <Widget>[
          negativeText != null
              ? TextButton(
                  child: Text(
                    negativeText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
          ElevatedButton(
            child: Text(
              positiveText,
            ),
            onPressed: () async {
              positiveFunction();
            },
          ),
        ],
      ),
    ),
  );
}

displayQuitDialog(context, title, subTitle) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: colors.cardBackgroundColor,
      title: Text(
        title,
        style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold, color: colors.headingTextColor),
      ),
      content: Text(
        subTitle,
        style: GoogleFonts.raleway(
            color: colors.headingTextColor.withOpacity(0.8)),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "No",
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        ElevatedButton(
          child: const Text(
            "Yes",
          ),
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}
