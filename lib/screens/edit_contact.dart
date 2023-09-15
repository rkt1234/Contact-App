// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class Edit extends StatefulWidget {
//   DocumentSnapshot doctoedit;
//   Edit({super.key, required this.doctoedit});

//   @override
//   State<Edit> createState() => _EditState();
// }

// class _EditState extends State<Edit> {
//   TextEditingController first = TextEditingController();
//   TextEditingController surname = TextEditingController();
//   TextEditingController phn = TextEditingController();
//   bool validate1 = true;
//   bool validate2 = true;
//   bool validate3 = true;
//   String message = "";
//   String message2 = "";
//   XFile? image;
//   late File pickedImage;
//   bool isPicked = false;
//   String imageurl = "";

//    _getFromGallery() async {
//     final ImagePicker _picker = ImagePicker();
//     image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
//     if (image != null) {
//       pickedImage = File(image!.path);
//       setState(() {
//         isPicked = true;
//       });
//     }
//   }
//   _uploadfirestorage() async {
//     if (image != null) {
//       pickedImage = File(image!.path);
//       setState(() {
//         isPicked = true;
//       });
//       Reference referenceroot = FirebaseStorage.instance.ref();
//       Reference refernceDirImages = referenceroot.child('profileprictures');
//       Reference referenceImageToUpload = refernceDirImages.child('image');
//       try {
//         await referenceImageToUpload.putFile(File(image!.path));
//         imageurl = await referenceImageToUpload.getDownloadURL();
//       } catch (error) {}
//     }
//   }

//   void initState() {
//     first = TextEditingController(text: widget.doctoedit['first name']);
//     surname = TextEditingController(text: widget.doctoedit['surname']);
//     phn = TextEditingController(text: widget.doctoedit['phone no']);

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 153, 220, 229),
//           automaticallyImplyLeading: false,
//           title: Text("Edit your contacts"),
//         ),
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     InkWell(
//       onTap: () {
//         _getFromGallery();
//         print("hello");
//       },
// child:isPicked?CircleAvatar(radius: 70,backgroundImage: FileImage(pickedImage),):CircleAvatar(radius: 70,backgroundImage:NetworkImage(widget.doctoedit['url']!=""?widget.doctoedit['url']:"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),)
//       //  CircleAvatar(
//       //     radius: 70,
//       //     backgroundImage: NetworkImage(widget.doctoedit['url'] !=
//       //             ''
//       //         ? widget.doctoedit['url']
//       //         : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
//     ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 TextField(
//                   controller: first,
//                   // onChanged: (value) {
//                   //   first = value;
//                   // },
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.person),
//                     errorText: validate1 ? null : message,
//                     labelText: 'First name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 TextField(
//                   controller: surname,
//                   // onChanged: (value) {
//                   //   surname = value;
//                   // },
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.person),
//                     labelText: 'Surname',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 TextField(
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   controller: phn,
//                   decoration: InputDecoration(
//                     errorText: validate2 && validate3
//                         ? null
//                         : (validate2 ? message2 : message),
//                     prefixIcon: Icon(Icons.phone),
//                     labelText: 'Mobile',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async{
//                     if (first.text != "")
//                       setState(() {
//                         validate1 = true;
//                       });
//                     if (phn.text != "")
//                       setState(() {
//                         validate2 = true;
//                       });
//                     if (phn.text.length == 10)
//                       setState(() {
//                         validate3 = true;
//                       });
//                     if (phn.text.length != 10)
//                       setState(() {
//                         validate3 = false;
//                         message2 = "10 digits needed";
//                       });
//                     if (first.text == "") {
//                       setState(() {
//                         validate1 = false;
//                         message = "This field can't be empty";
//                       });
//                     }
//                     if (phn.text == "") {
//                       setState(() {
//                         validate2 = false;
//                         message = "This field can't be empty";
//                       });
//                     }
// if (validate1 == true &&
//     validate2 == true &&
//     validate3 == true) {
//     await _uploadfirestorage();
//   widget.doctoedit.reference.update({
//     'first name': first.text,
//     'surname': surname.text,
//     'phone no': phn.text,
//     'url':imageurl
//   }).then((value) {
//     print("Update successful");
//     var snackBar = SnackBar(
//       content: Center(
//           child: Text(
//         'Updated successfully',
//         style: TextStyle(color: Colors.white),
//       )),
//       backgroundColor: Colors.green,
//     );
//     // Step 3
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     Navigator.pop(context);
//   });
// }
// },
//                   child: Text("Update"),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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

class Edit extends StatefulWidget {
  DocumentSnapshot doctoedit;
  Edit({super.key, required this.doctoedit});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool validate1 = true;
  bool validate2 = true;
  bool validate3 = true;
  String message = "";
  String message2 = "";
  String initial_phn_no = "";
  TextEditingController first = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phn = TextEditingController();

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
  void initState() {
    imageurl = widget.doctoedit['url'];
    initial_phn_no = widget.doctoedit['phone no'];
    first = TextEditingController(text: widget.doctoedit['first name']);
    surname = TextEditingController(text: widget.doctoedit['surname']);
    phn = TextEditingController(text: widget.doctoedit['phone no']);

    // TODO: implement initState
    super.initState();
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
              'Edit Contact',
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
                                          widget.doctoedit['url'] != ''
                                              ? widget.doctoedit['url']
                                              : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
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
                        controller: first,
                        style: GoogleFonts.montserrat(color: Colors.white),
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
                        controller: surname,
                        style: GoogleFonts.montserrat(color: Colors.white),
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
                        controller: phn,
                        style: GoogleFonts.montserrat(color: Colors.white),
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
                              'Update',
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
                            if (phn.text.length == 10)
                              setState(() {
                                validate3 = true;
                              });
                            if (phn.text.length != 10)
                              setState(() {
                                validate3 = false;
                                message2 = "10 digits needed";
                              });
                            if (first.text == "") {
                              setState(() {
                                validate1 = false;
                                message = "This field can't be empty";
                              });
                            }
                            if (phn.text == "") {
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
                              print("chalo aa gaya h ");

                              await _uploadfirestorage();
                              widget.doctoedit.reference.update({
                                'first name': first.text,
                                'surname': surname.text,
                                'phone no': phn.text,
                                'url': imageurl
                              }).then((value) {
                                setState(() {
                                  progress = false;
                                });
                                print("Update successful");
                                var snackBar = SnackBar(
                                  content: Center(
                                      child: Text(
                                    'Updated successfully',
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
                            }
                          },
                        ),
                      )
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
