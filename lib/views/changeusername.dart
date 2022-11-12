import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/profile.dart';
import 'package:news_app/views/search_screen.dart';

import '../utills/showToastMessage.dart';
import '../utills/theme.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key? key}) : super(key: key);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final _formKey = GlobalKey<FormState>();
  var newUsername = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newUsernameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newUsernameController.dispose();
    super.dispose();
  }

  FutureOr onGoBack(dynamic value) {
    // refreshData();
    setState(() {});
  }

  final firebaseInstance = FirebaseFirestore.instance;

  Future editProduct() async {
    // print("Product Id  $productId");
    try {
      // CommanDialog.showLoading();
      print("ok");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'username': newUsernameController.text,
      });
      print(FirebaseAuth.instance.currentUser!.uid);
      showToastMessage("Username Changed Successfully.", "success");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );

      // .update({"username": newUsername}).then((_) {
      // print("ok");
      // });
    } catch (error) {
      print(error);
    }
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
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
                            decoration: InputDecoration(
                              labelText: 'New Username: ',
                              hintText: 'Enter New Username',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: newUsernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Username';
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
                                  newUsername = newUsernameController.text;
                                });
                                editProduct();
                              }
                            },
                            child: Text(
                              'Change Username',
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
