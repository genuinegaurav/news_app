// // import 'package:flutter/material.dart';
// // import 'bookmarks_screen.dart';

// // class HomeScreenWidget extends StatefulWidget {
// //   final Function(String, String, String, String) addBookmark;
// //   final List<Map<String, dynamic>> bookmarks;
// //   final VoidCallback onBookmarksUpdated;
// //   final dynamic user;

// //   HomeScreenWidget({
// //     required this.addBookmark,
// //     required this.bookmarks,
// //     required this.onBookmarksUpdated,
// //     required this.user,
// //     required String username,
// //   });

// //   @override
// //   _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
// // }

// // class _HomeScreenWidgetState extends State<HomeScreenWidget> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     widget.onBookmarksUpdated();
// //   }

// //   void _removeBookmark(int index) {
// //     setState(() {
// //       widget.bookmarks.removeAt(index);
// //     });
// //     widget.onBookmarksUpdated();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Container(
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage('assets/bg.jpg'),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           Center(
// //             child: Text(
// //               'Welcome to Home Screen',
// //               style: TextStyle(fontSize: 24, color: Colors.white),
// //             ),
// //           ),
// //           Positioned(
// //             top: 16,
// //             right: 16,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.end,
// //               children: [
// //                 FloatingActionButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => BookmarksScreen(
// //                           bookmarks: widget.bookmarks,
// //                           removeBookmark: _removeBookmark,
// //                         ),
// //                       ),
// //                     ).then((_) {
// //                       widget.onBookmarksUpdated();
// //                       setState(() {});
// //                     });
// //                   },
// //                   child: Icon(Icons.bookmark),
// //                   backgroundColor: Colors.blue,
// //                 ),
// //                 SizedBox(height: 16),
// //                 FloatingActionButton(
// //                   onPressed: () {},
// //                   child: Icon(Icons.person),
// //                   backgroundColor: Colors.blue,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class HomeScreenWidget extends StatelessWidget {
//   final Function(String title, String link, String imgUrl, String description)
//       addBookmark;
//   final List<Map<String, dynamic>> bookmarks;
//   final VoidCallback onBookmarksUpdated;
//   final user;
//   final String username;

//   const HomeScreenWidget({
//     Key? key,
//     required this.addBookmark,
//     required this.bookmarks,
//     required this.onBookmarksUpdated,
//     required this.user,
//     required this.username,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/bg.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'VISIT YOUR FAVOURITE WEBSITES',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
//                 buildCardRow(
//                   context,
//                   'THE HINDU',
//                   'https://pbs.twimg.com/media/EY6wKckWoAAcSjO.jpg:large',
//                   'https://www.thehindu.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'TIMES OF INDIA',
//                   'https://m.media-amazon.com/images/I/71ybIlO9cfL.png',
//                   'https://timesofindia.indiatimes.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'INDIA TODAY',
//                   'https://play-lh.googleusercontent.com/XKVQpIEEGbjxsX5CFatbRv5b0FMMYJ9bYkhjFa0_XFaOG5iAu4Qz9aWFyK5yOe7R0n0',
//                   'https://www.indiatoday.in/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'NDTV',
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdYOfGWU9DBghK98TeZXSR1mwK097ckbAPhA&s',
//                   'https://www.ndtv.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'BBC WORLD',
//                   'https://static.wikia.nocookie.net/logopedia/images/2/22/BBC_World_1995.jpg/revision/latest?cb=20161104074841',
//                   'https://www.bbc.com/news/world',
//                 ),
//                 buildCardRow(
//                   context,
//                   'REUTERS',
//                   'https://www.reuters.com/pf/resources/images/reuters/reuters-default.webp?d=207',
//                   'https://www.reuters.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'ESPN',
//                   'https://www.sportico.com/wp-content/uploads/2023/08/ESPN.webp',
//                   'https://www.espn.in/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'ENTERTAINMENT WEEKLY',
//                   'https://variety.com/wp-content/uploads/2019/06/entertainment-weekly-logo.jpg?w=1000',
//                   'https://ew.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'VICE',
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5anBfITIUbSbX5Z6oOtFsxf6qoUfskKdMtA&s',
//                   'https://www.vice.com/en/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'VARIETY',
//                   'https://i0.wp.com/www.thewrap.com/wp-content/uploads/2023/06/variety-logo.jpg?fit=990%2C555&ssl=1',
//                   'https://variety.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'THE HOLLYWOOD REPORTER',
//                   'https://pbs.twimg.com/media/F6fXURUW4AAR6_H.jpg',
//                   'https://www.hollywoodreporter.com/',
//                 ),
//                 buildCardRow(
//                   context,
//                   'THE NEW YORK TIMES',
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_KFLmCHs9sIuuLs5bB_1FFaQqzuAynPdfuAhm5wMwbC8CD4aLtPPSeSBOO0fg9JxMsY&usqp=CAU',
//                   'https://www.nytimes.com/international/',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCardRow(
//       BuildContext context, String title, String imageUrl, String url) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewPage(url: url),
//         ),
//       ),
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 10.0), // Adjust vertical margin
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(150),
//         ),
//         elevation: 5,
//         child: Container(
//           height: 200, // Fixed height for all cards
//           margin: EdgeInsets.symmetric(
//               horizontal: 8.0), // Space from left and right
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(55),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 150, // Fixed height for images
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WebViewPage extends StatelessWidget {
//   final String url;

//   WebViewPage({required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web View'),
//         backgroundColor: Colors.blue,
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:news_1/bookmarks_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreenWidget extends StatefulWidget {
  final Function(String title, String link, String imgUrl, String description)
      addBookmark;
  final List<Map<String, dynamic>> bookmarks;
  final VoidCallback onBookmarksUpdated;
  final user;
  final String username;

  const HomeScreenWidget({
    Key? key,
    required this.addBookmark,
    required this.bookmarks,
    required this.onBookmarksUpdated,
    required this.user,
    required this.username,
  }) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'VISIT YOUR FAVOURITE WEBSITES',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  buildCardRow(
                    context,
                    'THE HINDU',
                    'https://pbs.twimg.com/media/EY6wKckWoAAcSjO.jpg:large',
                    'https://www.thehindu.com/',
                  ),
                  buildCardRow(
                    context,
                    'TIMES OF INDIA',
                    'https://m.media-amazon.com/images/I/71ybIlO9cfL.png',
                    'https://timesofindia.indiatimes.com/',
                  ),
                  buildCardRow(
                    context,
                    'INDIA TODAY',
                    'https://play-lh.googleusercontent.com/XKVQpIEEGbjxsX5CFatbRv5b0FMMYJ9bYkhjFa0_XFaOG5iAu4Qz9aWFyK5yOe7R0n0',
                    'https://www.indiatoday.in/',
                  ),
                  buildCardRow(
                    context,
                    'NDTV',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdYOfGWU9DBghK98TeZXSR1mwK097ckbAPhA&s',
                    'https://www.ndtv.com/',
                  ),
                  buildCardRow(
                    context,
                    'BBC WORLD',
                    'https://static.wikia.nocookie.net/logopedia/images/2/22/BBC_World_1995.jpg/revision/latest?cb=20161104074841',
                    'https://www.bbc.com/news/world',
                  ),
                  buildCardRow(
                    context,
                    'REUTERS',
                    'https://www.reuters.com/pf/resources/images/reuters/reuters-default.webp?d=207',
                    'https://www.reuters.com/',
                  ),
                  buildCardRow(
                    context,
                    'ESPN',
                    'https://www.sportico.com/wp-content/uploads/2023/08/ESPN.webp',
                    'https://www.espn.in/',
                  ),
                  buildCardRow(
                    context,
                    'ENTERTAINMENT WEEKLY',
                    'https://variety.com/wp-content/uploads/2019/06/entertainment-weekly-logo.jpg?w=1000',
                    'https://ew.com/',
                  ),
                  buildCardRow(
                    context,
                    'VICE',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5anBfITIUbSbX5Z6oOtFsxf6qoUfskKdMtA&s',
                    'https://www.vice.com/en/',
                  ),
                  buildCardRow(
                    context,
                    'VARIETY',
                    'https://i0.wp.com/www.thewrap.com/wp-content/uploads/2023/06/variety-logo.jpg?fit=990%2C555&ssl=1',
                    'https://variety.com/',
                  ),
                  buildCardRow(
                    context,
                    'THE HOLLYWOOD REPORTER',
                    'https://pbs.twimg.com/media/F6fXURUW4AAR6_H.jpg',
                    'https://www.hollywoodreporter.com/',
                  ),
                  buildCardRow(
                    context,
                    'THE NEW YORK TIMES',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_KFLmCHs9sIuuLs5bB_1FFaQqzuAynPdfuAhm5wMwbC8CD4aLtPPSeSBOO0fg9JxMsY&usqp=CAU',
                    'https://www.nytimes.com/international/',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarksScreen(
                          bookmarks: widget.bookmarks,
                          removeBookmark: _removeBookmark,
                        ),
                      ),
                    ).then((_) {
                      widget.onBookmarksUpdated();
                      setState(() {});
                    });
                  },
                  child: Icon(Icons.bookmark),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.person),
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardRow(
      BuildContext context, String title, String imageUrl, String url) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(url: url),
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0), // Adjust vertical margin
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Adjusted border radius
        ),
        elevation: 5,
        child: Container(
          height: 200, // Fixed height for all cards
          margin: EdgeInsets.symmetric(
              horizontal: 0.0), // Space from left and right
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Adjusted border radius
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150, // Fixed height for images
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeBookmark(int index) {
    setState(() {
      widget.bookmarks.removeAt(index);
    });
    widget.onBookmarksUpdated();
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
        backgroundColor: Colors.blue,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
