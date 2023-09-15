// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_list_flutter_application/authentication/auth.dart';
import 'package:contact_list_flutter_application/authentication/signup.dart';
import 'package:contact_list_flutter_application/screens/activity.dart';
import 'package:contact_list_flutter_application/screens/add_contact.dart';
import 'package:contact_list_flutter_application/screens/edit_contact.dart';
// import 'package:contact_list_flutter_application/screens/add_contact.dart';
// import 'package:contact_list_flutter_application/screens/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Contactlist extends StatefulWidget {
  String email = "";
  Contactlist({super.key, required this.email});

  @override
  State<Contactlist> createState() => _ContactlistState();
}

class _ContactlistState extends State<Contactlist> {
  @override
  void initState() {}
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection(widget.email);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 30, 30, 30),
                        title: Center(
                          child: Text(
                            'Are you sure?',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                child: Text(
                                  'Confirm',
                                  style: GoogleFonts.montserrat(
                                    textStyle:
                                        TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                                onPressed: () async {
                                  await Auth.logout();
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                  // snapshotii.data!.docs[index].reference.delete();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.montserrat(
                                    textStyle:
                                        TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                                onPressed: () async {
                                  // await Auth.logout();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          automaticallyImplyLeading: false,
          title: Text(
            'My Contacts',
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: StreamBuilder<QuerySnapshot>(
              stream: ref.snapshots(),
              builder: (context, snapshotii) {
                if (!snapshotii.hasData || snapshotii.data!.docs.isEmpty)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/empty.json'),
                      Center(
                        child: Text(
                          'No saved contacts',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  );
                else
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshotii.data?.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // Within the `FirstRoute` widget
                        onTap: () {
                          String firstname =
                              snapshotii.data!.docs[index]['first name'];
                          String secondname =
                              snapshotii.data!.docs[index]['surname'];
                          String phone =
                              snapshotii.data!.docs[index]['phone no'];
                          String image = snapshotii.data!.docs[index]['url'] !=
                                  ''
                              ? snapshotii.data!.docs[index]['url']
                              : "https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Activity(
                                      firstname: firstname,
                                      image: image,
                                      phone: phone,
                                      secondname: secondname,
                                    )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration:
                              _getradius(index, snapshotii.data!.docs.length),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context:
                                        context, // user must tap button!
                                    builder: (BuildContext context) {
                                      return Image.network(snapshotii.data!
                                                  .docs[index]['url'] !=
                                              ""
                                          ? snapshotii.data!.docs[index]
                                              ['url']
                                          : "https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg");
                                    },
                                  );
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: snapshotii.data!.docs[index]
                                                  ['url'] !=
                                              ""
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  (snapshotii.data!
                                                      .docs[index]['url'])),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  "https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg"),
                                            )
                                      //  Text(snapshotii.data!.docs[index]
                                      //     ['first name'][0],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  snapshotii.data!.docs[index]
                                          ['first name'] +
                                      ' ' +
                                      snapshotii.data!.docs[index]
                                          ['surname'],

                                   overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  // Within the `FirstRoute` widget
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Edit(
                                              doctoedit: snapshotii
                                                  .data!.docs[index])),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Color.fromARGB(
                                              255, 30, 30, 30),
                                          title: Center(
                                            child: Text(
                                              'Are you sure?',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          content:
                                              const SingleChildScrollView(
                                            child: ListBody(),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                              children: [
                                                TextButton(
                                                  child: Text(
                                                    'Confirm',
                                                    style: GoogleFonts
                                                        .montserrat(
                                                      textStyle: TextStyle(
                                                        color: Colors
                                                            .lightBlue,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await snapshotii
                                                          .data!
                                                          .docs[index]
                                                          .reference
                                                          .delete()
                                                          .then((value) {
                                                        print("deleted");
                                                        var snackBar =
                                                            SnackBar(
                                                          content: Center(
                                                              child: Text(
                                                            'Deleted',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                          backgroundColor:
                                                              Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      50,
                                                                      50),
                                                        );
                                                        // Step 3
                                                        ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      });
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    'Cancel',
                                                    style: GoogleFonts
                                                        .montserrat(
                                                      textStyle: TextStyle(
                                                        color: Colors
                                                            .lightBlue,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.brown,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
              },
            )));
  }

  BoxDecoration _getradius(int index, int l) {
    if (index == 0 && l == 1)
      return BoxDecoration(
          color: Color.fromARGB(255, 38, 38, 40),
          borderRadius: BorderRadius.circular(10));
    else if (index == 0 && l != 1)
      return BoxDecoration(
          color: Color.fromARGB(255, 38, 38, 40),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)));
    else if (index == l - 1)
      return BoxDecoration(
          color: Color.fromARGB(255, 38, 38, 40),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)));
    else
      return BoxDecoration(
          color: Color.fromARGB(255, 38, 38, 40),
          borderRadius: BorderRadius.circular(0));
  }
}
