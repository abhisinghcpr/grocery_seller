// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:grocery_seller/view/screen/widgets/aaaaa.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> slidekey = GlobalKey();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Color(0xFF0073CC),
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//     final screenSize = MediaQuery.of(context).size;
//     final double height = screenSize.height;
//
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         key: slidekey,
//         drawer: const CustomDrawer(
//         ),
//         floatingActionButton: Padding(
//           padding: EdgeInsets.only(bottom: height * 0.03),
//           child: FloatingActionButton(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             backgroundColor: Color(0xFF0073CC),
//             onPressed: () {
//               slidekey.currentState?.openDrawer();
//             },
//             child: Image.asset(
//               'assets/images/img_5.png',
//               width: 25,
//               height: 25,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               height: 250,
//               decoration: const BoxDecoration(
//                 color: Colors.black12,
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/img_2.png"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 35,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       slidekey.currentState?.openDrawer();
//                     },
//                     child: Container(
//                       height: 40,
//                       child: ListTile(
//                         leading: Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(width: 2, color: Colors.white),
//                           ),
//                           child: Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: const Center(
//                           child: Row(
//                             children: [
//                               SizedBox(width: 50),
//                               CircleAvatar(
//                                 child: SizedBox(
//                                   height: 30,
//                                   width: 30,
//                                   child: Image(
//                                     image: AssetImage(
//                                         'assets/images/img_3.png'),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               Text(
//                                 "Brand Name",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TabBar(
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.greenAccent,
//                     indicatorColor: Colors.white,
//                     tabs: [
//                       Container(
//                         height: 45,
//                         width: 80,
//                         child: Tab(text: 'Chat'),
//                       ),
//                       Container(
//                         height: 45,
//                         width: 80,
//                         child: Tab(text: 'Group Chat'),
//                       ),
//                       Container(
//                         height: 45,
//                         width: 80,
//                         child: Tab(text: 'Watch'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   Center(child: Text('All Chat Screen')),
//                   Center(child: Text('Group Chat Screen')),
//                   Center(child: Text('Watch Screen')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
