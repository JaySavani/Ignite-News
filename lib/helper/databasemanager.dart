import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserData(String username, String uid) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({'username': username, 'uid': uid});
  // FirebaseAuth auth = FirebaseAuth.instance;
  // String uid = auth.currentUser!.uid.toString();
  // users.add();
  // return;
}
