import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/views/changepassword.dart';
import 'package:news_app/views/changeusername.dart';
import 'package:news_app/views/login_page.dart';
import 'package:news_app/views/search_screen.dart';
import 'package:news_app/utills/theme.dart';

import '../utills/showToastMessage.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String username = '';
  bool _loding = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    // getusername();
  }

  final firebaseInstance = FirebaseFirestore.instance;
// Map userProfileData = {'userName': ''};

  Future<void> getUserName() async {
    // print("user id ${authController.userId}");
    try {
      var response = await firebaseInstance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      if (response.docs.length > 0) {
        username = response.docs[0]["username"];

        // userProfileData['userName'] = response.docs[0]['username'];
      }
      // print(userProfileData);
    } on FirebaseException catch (e) {
      print('e : $e');
    } catch (error) {
      print('error : $error');
    }
    setState(() {
      _loding = false;
    });
  }

  FutureOr onGoBack(dynamic value) {
    // refreshData();
    setState(() {});
  }

  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      showToastMessage("Verification Email has been sent.", "success");
      await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (context) => LoginPage(),
    ),
    (route) => false);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.orangeAccent,
      //     content: Text(
      //       'Verification Email has been sent',
      //       style: TextStyle(fontSize: 18.0, color: Colors.black),
      //     ),
      //   ),
      // );
    } else {
      showToastMessage("Email Already Verified.", "warning");
    }
  }

  Widget _headerWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.png"),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(username),
                  SizedBox(height: 10),
                  Text(
                    '$email',
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              height: 10,
              color: is_dark ? Colors.white : Colors.black)
        ],
      ),
    );
  }

  Widget _settingRow(
    BuildContext context,
    IconData icon1,
    String text,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Icon(
              icon1,
            ),
            SizedBox(width: 10),
            Text(text),
            Expanded(child: SizedBox()),
          ],
        ),
        onTap: () {
          if (text == "Change Password") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePassword(),
              ),
            ).then(onGoBack);
          } else if (text == "Change Username") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangeUsername(),
              ),
            );
          }
          else verifyEmail();
        },
      ),
    );
  }

  Widget _logout(BuildContext context, IconData icon1, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Icon(icon1, color: is_dark ? Colors.white : Colors.black),
            SizedBox(width: 10),
            Text(text),
            Expanded(child: SizedBox()),
          ],
        ),
        onTap: () async => {
          await FirebaseAuth.instance.signOut(),
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false),
          showToastMessage("Logout Successful.", "success"),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: is_dark
          ? ThemeData(
              brightness: Brightness.dark,
            )
          : ThemeData(
              brightness: Brightness.light,
            ),
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            color: is_dark ? Colors.white : Colors.black,
          ),
          backgroundColor: is_dark ? Colors.black12 : Colors.white,
          title: Text(
            "Profile",
            style: TextStyle(
              color:
                  is_dark ? Colors.white : Color.fromARGB(255, 102, 109, 255),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    )).then(onGoBack);
              },
              icon: Icon(Icons.search,
                  color: is_dark ? Colors.white : Colors.black),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (is_dark == false)
                    is_dark = true;
                  else
                    is_dark = false;
                });
              },
              icon: Icon(
                is_dark ? Icons.dark_mode : Icons.light_mode,
                color: is_dark ? Colors.white : Colors.black,
              ),
            ),
          ],
          elevation: 0.0,
        ),
        body: _loding
            ? SpinKitSpinningLines(
                size: 100.0,
                color: is_dark ? Colors.white : Colors.black,
              )
            : SafeArea(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _headerWidget(context),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _settingRow(
                              context,
                              Icons.verified_outlined,
                              user!.emailVerified
                                  ? 'verified'
                                  : 'Verify Email'),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            height: 0,
                            color: is_dark ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 10),
                          _settingRow(
                              context, Icons.edit_rounded, 'Change Username'),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            height: 0,
                            color: is_dark ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 10),
                          _settingRow(
                              context, Icons.edit_rounded, 'Change Password'),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            height: 0,
                            color: is_dark ? Colors.white : Colors.black,
                          ),
                          // SizedBox(height: 5),
                          _logout(context, Icons.exit_to_app, 'Logout'),
                          Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            height: 0,
                            color: is_dark ? Colors.white : Colors.black,
                          )
                        ],
                      ),
                      // ),
                    ))
                  ],
                ),
              ),
      ),
    );
  }
}
