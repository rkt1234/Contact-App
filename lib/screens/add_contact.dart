import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_list_flutter_application/authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  bool validate1 = true;
  bool validate2 = true;
  bool validate3 = true;
  String message = "";
  String message2 = "";
  String first = "";
  String surname = "";
  String phn = "";
  XFile? image;
  late File pickedImage;
  bool isPicked = false;
  String imageurl = "";
  bool progress = false;
  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      pickedImage = File(image!.path);
      setState(() {
        isPicked = true;
      });
    }
  }

  _uploadfirestorage() async {
    if (image != null) {
      pickedImage = File(image!.path);
      setState(() {
        isPicked = true;
      });
      Reference referenceroot = FirebaseStorage.instance.ref();
      Reference refernceDirImages = referenceroot.child('profileprictures');
      Reference referenceImageToUpload = refernceDirImages.child('image');
      try {
        await referenceImageToUpload.putFile(File(image!.path));
        imageurl = await referenceImageToUpload.getDownloadURL();
      } catch (error) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 30, 30, 30),
            automaticallyImplyLeading: false,
            title: Text(
              'Add Contact',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, letterSpacing: .5),
              ),
            ),
          ),
          // resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            _getFromGallery();
                          },
                          child: isPicked == false
                              ? Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add image',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 150, 150, 150),
                                            letterSpacing: .5),
                                      ),
                                    ),
                                  ],
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(pickedImage))),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        style: GoogleFonts.montserrat(color: Colors.white),
                        onChanged: (value) {
                          first = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorText: validate1 ? null : message,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 150, 150, 150),
                          ),
                          hintText: "Enter first name",
                          hintStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          labelText: 'First name',
                          labelStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        style: GoogleFonts.montserrat(color: Colors.white),
                        onChanged: (value) {
                          surname = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 150, 150, 150),
                          ),
                          hintText: "Enter surname",
                          hintStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          labelText: 'Surname',
                          labelStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        style: GoogleFonts.montserrat(color: Colors.white),
                        onChanged: (value) {
                          phn = value;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorText: validate2 && validate3
                              ? null
                              : (validate2 ? message2 : message),
                          prefixIcon: const Icon(Icons.phone,
                              color: Color.fromARGB(255, 150, 150, 150)),
                          hintText: "Enter mobile no",
                          hintStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          labelText: 'Mobile',
                          labelStyle: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 150, 150, 150)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 98, 95, 106)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Save',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (first != "")
                              setState(() {
                                validate1 = true;
                              });
                            if (phn != "")
                              setState(() {
                                validate2 = true;
                              });
                            if (phn.length == 10)
                              setState(() {
                                validate3 = true;
                              });
                            if (phn.length != 10)
                              setState(() {
                                validate3 = false;
                                message2 = "10 digits needed";
                              });
                            if (first == "") {
                              setState(() {
                                validate1 = false;
                                message = "This field can't be empty";
                              });
                            }
                            if (phn == "") {
                              setState(() {
                                validate2 = false;
                                message = "This field can't be empty";
                              });
                            }
                            if (validate1 == true &&
                                validate2 == true &&
                                validate3 == true) {
                              setState(() {
                                progress = true;
                              });
                              print("ho rha h upload");
                              await _uploadfirestorage();
                              FirebaseAuth auth = FirebaseAuth.instance;
                              final User? users = auth.currentUser;
                              FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              CollectionReference user =
                                  firestore.collection(users!.email.toString());
                              setState(() async {
                                print("add ho rha h");

                                user.add({
                                  'first name': first,
                                  'surname': surname,
                                  'phone no': phn,
                                  'url': imageurl
                                }).then((value) {
                                  // Auth.phone_set.add(phn);
                                  setState(() {
                                    progress = false;
                                  });
                                  print("Add successful");
                                  var snackBar = SnackBar(
                                    content: Center(
                                        child: Text(
                                      'Added successfully',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    backgroundColor:
                                        Color.fromARGB(255, 50, 50, 50),
                                  );
                                  // Step 3
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                });
                                // else
                                // {
                                //   setState(() {
                                //     progress = false;
                                //   });
                                //   var snackBar = SnackBar(
                                //     content: Center(
                                //         child: Text(
                                //       'Phone number already exists',
                                //       style: TextStyle(color: Colors.white),
                                //     )),
                                //     backgroundColor:
                                //         Colors.red,
                                //   );
                                //   // Step 3
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(snackBar);
                                // }
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              progress
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Container()
            ],
          )),
    );
  }
}
