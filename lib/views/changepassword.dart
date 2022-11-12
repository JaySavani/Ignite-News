import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/login_page.dart';
import 'package:news_app/views/search_screen.dart';
import 'package:news_app/utills/theme.dart';

import '../utills/showToastMessage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var newPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newPasswordController.dispose();
    super.dispose();
  }

  FutureOr onGoBack(dynamic value) {
    // refreshData();
    setState(() {});
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      showToastMessage("Your Password has been Changed. Login again!","success");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.orangeAccent,
      //     content: Text(
      //       'Your Password has been Changed. Login again !',
      //       style: TextStyle(fontSize: 18.0),
      //     ),
      //   ),
      // );
    } catch (e) {}
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
          backgroundColor: is_dark ? Colors.black12 : Colors.white,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: is_dark ? Colors.white : Colors.black,
          ),
          title: Text(
            "Ignite News",
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
                // .then(onGoBack);
              },
              icon: Icon(Icons.search,
                  color: is_dark ? Colors.white : Colors.black),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (is_dark == false)
                    setdark(true);
                  else
                    setdark(false);
                });
              },
              icon: Icon(
                is_dark ? Icons.dark_mode : Icons.light_mode,
                color: is_dark ? Colors.white : Colors.black,
              ),
            ),
          ],
          // centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'New Password: ',
                              hintText: 'Enter New Password',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: newPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  newPassword = newPasswordController.text;
                                });
                                changePassword();
                              }
                            },
                            child: Text(
                              'Change Password',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
