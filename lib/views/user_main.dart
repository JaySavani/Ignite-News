// import 'package:flutter/material.dart';
// import 'package:news_app/views/home.dart';
// import 'package:news_app/views/profile.dart';
// import 'package:news_app/views/search_screen.dart';
// // import 'package:news_app/views/theme.dart';
//
//
// class UserMain extends StatefulWidget {
//   UserMain({Key? key}) : super(key: key);
//
//   @override
//   _UserMainState createState() => _UserMainState();
// }
//
// class _UserMainState extends State<UserMain> {
// bool is_dark = false;
//
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     Home(is_dark),
//     Profile(),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: is_dark
//               ? ThemeData(
//             brightness: Brightness.dark,
//           )
//               : ThemeData(
//             brightness: Brightness.light,
//           ),
//         home: Scaffold(
//           appBar: AppBar(
//             backgroundColor: is_dark ? Colors.black12 : Colors.white,
//             title: Text(
//               "Ignite News",
//               style: TextStyle(
//                 color:
//                 is_dark ? Colors.white : Color.fromARGB(255, 102, 109, 255),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SearchScreen(),
//                       ));
//                 },
//                 icon: Icon(Icons.search,
//                     color: is_dark ? Colors.white : Colors.black),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (is_dark == false)
//                       setdark(true);
//                     else
//                       setdark(false);
//                   });
//                 },
//                 icon: Icon(
//                   is_dark ? Icons.dark_mode : Icons.light_mode,
//                   color: is_dark ? Colors.white : Colors.black,
//                 ),
//               ),
//             ],
//             // centerTitle: true,
//             elevation: 0.0,
//           ),
//         body: _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: BottomNavigationBar(
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home,color: is_dark ? Colors.white : Colors.black,),
//               label: 'Dashboard',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person,color: is_dark ? Colors.white : Colors.black),
//               label: 'My Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.blueAccent,
//           onTap: _onItemTapped,
//         ),
//     ),
//       );
//   }
// }
