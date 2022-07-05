import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

displayDialog(context, positiveText, negativeText, Function positiveFunction,
    title, subTitle, {dismissDialog, willPop}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissDialog ?? true,
    builder: (context) => WillPopScope(
      onWillPop: () async => willPop ?? true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          title,
          style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
        ),
        content: Text(
          subTitle,
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
            child: Text(positiveText,),
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
      title: Text(
        title,
        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
      ),
      content: Text(
        subTitle,
      ),
      actions: <Widget>[
        TextButton(
                child: Text(
                  "No",
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
        ElevatedButton(
          child: Text("Yes",),
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}
