import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Activity extends StatefulWidget {
  String firstname, secondname, phone, image;
  Activity(
      {super.key,
      required this.firstname,
      required this.image,
      required this.phone,
      required this.secondname});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        automaticallyImplyLeading: false,
        title: Text(
          'Past Activities',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 38, 38, 40),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Center(
                      child: Text(widget.firstname + '  ' + widget.secondname,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 38, 38, 40),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                      child: Text(widget.phone,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Call  Logs",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color.fromARGB(255, 38, 38, 40)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 246, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Icon(Icons.phone_callback))),
                          Text(
                            "Incoming",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          Text(
                            "May 18 20:20 PM",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 38, 38, 40)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 246, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child:
                                  Center(child: Icon(Icons.phone_forwarded))),
                          Text(
                            "Outgoing",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          Text(
                            "May 19 20:20 PM",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 38, 38, 40)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 246, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Icon(
                                Icons.phone_missed,
                                color: Colors.red,
                              ))),
                          Text(
                            "Missed Call",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          Text(
                            "May 20 20:20 PM",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 38, 38, 40)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 246, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Icon(Icons.phone_callback))),
                          Text(
                            "Incoming",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          Text(
                            "May 21 20:20 PM",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Color.fromARGB(255, 38, 38, 40)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 246, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child:
                                  Center(child: Icon(Icons.phone_forwarded))),
                          Text(
                            "Outgoing",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          Text(
                            "May 22 20:20 PM",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
