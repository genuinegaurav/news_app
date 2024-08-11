// import 'package:flutter/material.dart';
// import 'sports_screen.dart';
// import 'entertainment_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   void _toggleTheme() {
//     setState(() {
//       _isDarkMode = !_isDarkMode;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AIformed',
//       theme: _isDarkMode
//           ? ThemeData.dark().copyWith(
//               scaffoldBackgroundColor: Colors.black,
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.grey[900],
//                 iconTheme: IconThemeData(color: Colors.white),
//               ),
//               textTheme: TextTheme(
//                 bodyLarge: TextStyle(color: Colors.white),
//                 bodyMedium: TextStyle(color: Colors.white70),
//                 titleLarge: TextStyle(color: Colors.white),
//               ),
//             )
//           : ThemeData.light().copyWith(
//               scaffoldBackgroundColor: Colors.white,
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.blue,
//                 iconTheme: IconThemeData(color: Colors.white),
//               ),
//               textTheme: TextTheme(
//                 bodyLarge: TextStyle(color: Colors.black),
//                 bodyMedium: TextStyle(color: Colors.black54),
//                 titleLarge: TextStyle(color: Colors.black),
//               ),
//             ),
//       home: HomeScreen(onThemeToggle: _toggleTheme, isDarkMode: _isDarkMode),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final VoidCallback onThemeToggle;
//   final bool isDarkMode;

//   const HomeScreen(
//       {Key? key, required this.onThemeToggle, required this.isDarkMode})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Top half
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                     'https://media.licdn.com/dms/image/D5612AQEjjUI_Q26rVw/article-cover_image-shrink_720_1280/0/1718453975364?e=1726704000&v=beta&t=qio_ZnbyWUnNBrVx2m5ORwAuNBfNiz_Pe0BduQuHBkk'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.5),
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'AIformed',
//                 style: TextStyle(
//                   fontSize: 60,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 10.0,
//                       color: Colors.black,
//                       offset: Offset(0.0, 0.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Bottom half
//           Expanded(
//             child: Container(
//               color: isDarkMode ? Colors.black : Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Sports Button
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   SportsScreen(isDarkMode: isDarkMode),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           elevation: 5,
//                         ),
//                         child: Text(
//                           'Sports',
//                           style: TextStyle(
//                             fontSize: 26,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Entertainment Button
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   EntertainmentScreen(isDarkMode: isDarkMode),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           elevation: 5,
//                         ),
//                         child: Text(
//                           'Entertainment',
//                           style: TextStyle(
//                             fontSize: 26,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Theme Toggle Button
//                   IconButton(
//                     icon: Icon(
//                         isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
//                         color: Colors.blue),
//                     onPressed: onThemeToggle,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
