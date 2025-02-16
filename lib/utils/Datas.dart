import 'package:flutter/material.dart';

double ScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double ScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

TextStyle basic() {
  return const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontFamily: 'Inter',
      decoration: TextDecoration.none);
}

TextStyle heading() {
  return const TextStyle(
      fontSize: 40,
      fontFamily: "Inter",
      color: Colors.white,
      decoration: TextDecoration.none);
}

Text BasicText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: "Inter-reg",
      fontSize: 24,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
  );
}

List<Map<String, String>> speakers = [
  {"image": "lib/assets/images/tanu.png", "title": "Ashneer Grover"},
  {"image": "lib/assets/images/tanu.png", "title": "Tanu Jain"},
  {"image": "lib/assets/images/tanu.png", "title": "Himesh Madaan"},
  {"image": "lib/assets/images/tanu.png", "title": "Prateek Mittal"},
  {"image": "lib/assets/images/tanu.png", "title": "Ashish Chandra"},
  {"image": "lib/assets/images/tanu.png", "title": "Aakash Anand"},
  {"image": "lib/assets/images/tanu.png", "title": "Anuv Jain"},

];

List<Map<String, String>> events = [
  
 
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Opening Ceremony",
    "date": "19 Feb",
    "time": "5:30 P.M",
    "venue":"Main Audi",
    "route" : "/openingcer"
  },
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Internship Fair",
    "date": "19 Feb",
    "time": "10:00 A.M",
    "venue":"SBOP Lawns",
    "route" : "/internshipfair"
  },
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Biz Conclave",
    "date": "19 Feb",
    "time": "11:00 A.M",
    "venue":"Main Audi",
    "route" : "/bizconclave"
  },
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Youtube Connect",
    "date": "19 Feb",
    "time": "12:30 P.M",
    "venue":"Main Audi",
    "route" : "/youtubeconnect"
  },
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Networking Carnival",
    "date": "19 Feb",
    "time": "4:00 P.M",
    "venue":"SBOP Lawns",
    "route" : "/networking"
  },
  {
    "image": "lib/assets/images/internship_fair.png",
    "title": "Unwind",
    "date": "19 Feb",
    "time": "5:00 P.M",
    "venue":"OAT",
    "route" : "/unwind"
  },



];
