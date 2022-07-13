import 'package:flutter/material.dart';

import '../screens/edit_profile.dart';

const darkColor = Color(0xFF49535C);

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var montserrat = TextStyle(
      fontSize: 12,
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
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
                          color: Color(0xffA0A4A8),
                          borderRadius: BorderRadius.only(
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
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg"),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sumithra",
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
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
                              const SizedBox(height: 8),
                              Text(
                                "CB.EN.U4CSE19247",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: darkColor,
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
                          " E-Mail: \n GitHub Account: ",
                          style: montserrat,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          " Phone Number: \n Instagram: ",
                          style: montserrat,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("sums@gmail.com", style: montserrat),
                        Text("sumithra1306", style: montserrat),
                        const SizedBox(height: 16),
                        Text("1234567890", style: montserrat),
                        Text("sumiithraa_sudhakar", style: montserrat),
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
                          style: buildMontserrat(
                            const Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Starred",
                          style: buildMontserrat(darkColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: const VerticalDivider(
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "17",
                          style: buildMontserrat(
                            const Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "RSVP",
                          style: buildMontserrat(darkColor),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   child: const VerticalDivider(
                    //     color: Color(0xFF9A9A9A),
                    //   ),
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "13",
                    //       style: buildMontserrat(
                    //         const Color(0xFF000000),
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Upcoming this week",
                    //       style: buildMontserrat(darkColor),
                    //     )
                    //   ],
                    // ),
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
    return TextStyle(
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
      ..arcToPoint(Offset(114, size.height), radius: Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
