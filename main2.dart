// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv package
// import 'sports_screen.dart'; // Import the sports screen
// import 'entertainment_screen.dart'; // Import the entertainment screen

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
//   await dotenv.load(); // Load environment variables
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AIformed',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.black,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

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
//               color: Colors.black,
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
//                               builder: (context) => SportsScreen(),
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
//                               builder: (context) => EntertainmentScreen(),
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
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
