import 'dart:convert';

import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../utils/utils.dart';

const darkColor = Color(0xFF49535C);

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard>
    with AutomaticKeepAliveClientMixin {
  String _userName = "", _email = "", _starred = "", _rsvp = "";

  getUserData() async {
    _userName = await getName;
    _email = await getEmailID;
    try {
      setState(() {});
    } catch (e) {
      print(e);
    }

    //get RSVP and count data
    var res =
        await makePostRequest(null, "/user/userStats", null, true, context);
    if (res.statusCode == 200) {
      var decodedData = json.decode(res.body);
      _starred = decodedData['starred'].toString();
      _rsvp = decodedData['rsvp'].toString();
      try {
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: AvatarClipper(),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: colors.accentColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 11,
                      top: 50,
                      child: Row(
                        children: [
                          //TODO: Add first name first letter
                          CircleAvatar(
                            child: Text(
                              _userName.isNotEmpty
                                  ? _userName.toUpperCase()[0]
                                  : '',
                              style: GoogleFonts.raleway(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: colors.cardBackgroundColor,
                            radius: 50,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: AutoSizeText(
                                    _userName,
                                    maxLines: 1,
                                    style: GoogleFonts.raleway(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: colors.primaryTextColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, right: 30),
                                  child: AutoSizeText(
                                    _email,
                                    maxLines: 1,
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                                      fontSize: 20,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 8.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          _starred=="" ? "0" : _starred,
                          style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Starred",
                          style: buildMontserrat(darkColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          _rsvp=="" ? "0" : _rsvp,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "RSVP",
                          style: buildMontserrat(darkColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.raleway(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
