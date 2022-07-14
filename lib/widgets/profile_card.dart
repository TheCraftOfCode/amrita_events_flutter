import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

import '../screens/edit_profile.dart';

const darkColor = Color(0xFF49535C);

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var montserrat = const TextStyle(
      fontSize: 12,
    );
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
                            child: Text('N',style: GoogleFonts.raleway(fontSize: 40,fontWeight: FontWeight.bold),),
                            backgroundColor: colors.cardBackgroundColor,
                            radius: 50,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sumithra",
                                    style: GoogleFonts.raleway(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: colors.primaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: colors.primaryTextColor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile()));
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 50),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          " E-Mail:",
                          style: montserrat,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          " Phone Number:",
                          style: montserrat,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("sums@gmail.com", style: montserrat),
                        const SizedBox(height: 16),
                        Text("1234567890", style: montserrat),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "60",
                          style: GoogleFonts.raleway(
                            color: colors.primaryTextColor,
                            fontWeight: FontWeight.bold,
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
                          "17",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            color: colors.primaryTextColor,

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
              const SizedBox(height: 8)
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
