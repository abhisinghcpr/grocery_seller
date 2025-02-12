// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class HomeScreennn extends StatelessWidget {
//   const HomeScreennn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(
//     //   const SystemUiOverlayStyle(
//     //     statusBarColor: Color(0xFF0073CC),
//     //     statusBarIconBrightness: Brightness.light,
//     //   ),
//     // );
//     final screenSize = MediaQuery.of(context).size;
//     final double height = screenSize.height;
//
//     return Scaffold(
//
//       drawer: const CustomDrawer(), // Drawer Implemented Here
//       // floatingActionButton: Padding(
//       //   padding: EdgeInsets.only(bottom: height * 0.03),
//       //   child: FloatingActionButton(
//       //     shape: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.circular(10),
//       //     ),
//       //     backgroundColor: const Color(0xFF0073CC),
//       //     onPressed: () {
//       //       // Add Navigation Logic Here
//       //     },
//       //     child: Image.asset(
//       //       'assets/images/img_5.png',
//       //       width: 25,
//       //       height: 25,
//       //     ),
//       //   ),
//       // ),
//       body: Column(
//         children: [
//           Container(
//             height: 250,
//             decoration: const BoxDecoration(
//               color: Colors.black12,
//               image: DecorationImage(
//                 image: AssetImage("assets/images/img_2.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 35),
//                 const SizedBox(height: 20),
//                 const TabBar(
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.greenAccent,
//                   indicatorColor: Colors.white,
//                   tabs: [
//                     Tab(text: 'Chat'),
//                     Tab(text: 'Group Chat'),
//                     Tab(text: 'Watch'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 Center(child: Text("Chat Section")),
//                 Center(child: Text("Group Chat Section")),
//                 Center(child: Text("Watch Section")),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const UserAccountsDrawerHeader(
//             accountName: Text("John Doe"),
//             accountEmail: Text("johndoe@gmail.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 "J",
//                 style: TextStyle(fontSize: 24.0),
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: const Text('About'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
