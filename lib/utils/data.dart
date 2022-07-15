//Roll
//Name
//Roll No
//Phone No
//Picture

class PeopleData {
  final String? rollNo;
  final String name;
  final String phoneNo;
  final String pictureURL;
  String? instagram;
  String? mail;

  PeopleData(
      {this.instagram,
      this.mail,
      this.rollNo,
      required this.name,
      required this.phoneNo,
      required this.pictureURL});


}



var digitalContentTeam = [
  PeopleData(
      rollNo: "CB.EN.U4CSE19352",
      name: "SOORYA S",
      phoneNo: "9080336540",
      pictureURL: "assets/developer_pictures/soorya.jpg",
      mail: "soorya.s27@gmail.com",
      instagram: "https://www.instagram.com/the_convoluted_soul/"),
  PeopleData(
      rollNo: "CB.EN.U4CSE19038",
      name: "NIRMAL K",
      instagram: "https://www.instagram.com/homenum_.revelio/",
      phoneNo: "8220589062",
      mail: "nirmalkarthikeyan1503@gmail.com",
      pictureURL: "assets/developer_pictures/nirmal.jpg"),
  PeopleData(
    rollNo: "CB.EN.U4CSE19247",
    name: "SUMITHRA S",
    phoneNo: "7598050765",
    instagram: "https://instagram.com/sumiithraa_sudhakar",
    mail: "sumisooriya@gmail.com",
    pictureURL: "assets/developer_pictures/sumi.jpg"
  ),
];


