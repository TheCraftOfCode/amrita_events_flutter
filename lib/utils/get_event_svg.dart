// Image.asset(
// 'assets/events_empty.png',
// fit: BoxFit.contain,
// )

// Image.asset(
// 'assets/events_empty.png',
// fit: BoxFit.contain,
// )

// Image.asset(
// 'assets/mask.png',
// width: horizontalCenteredDisplacement,
// fit: BoxFit.fill,
// // )

//SvgPicture.asset(widget.imageUrl)

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

getEventImage(String eventTypeString, width) {
  switch (eventTypeString) {
    case 'FINE ARTS':
      return SvgPicture.asset("assets/svg/art.svg",
          fit: BoxFit.fill, width: width);
    case 'LITERARY':
      return SvgPicture.asset("assets/svg/literary.svg",
          fit: BoxFit.fill, width: width);
    case 'DANCE':
      return SvgPicture.asset("assets/svg/dance.svg",
          fit: BoxFit.fill, width: width);
    case 'MUSIC':
      return SvgPicture.asset("assets/svg/music.svg",
          fit: BoxFit.fill, width: width);
    case 'THEATRE':
      return Image.asset(
        'assets/mask.png',
        width: width,
        fit: BoxFit.fill,
      );
    case 'INFORMALS':
      return SvgPicture.asset("assets/svg/informals.svg",
          fit: BoxFit.fill, width: width);
  }
}
