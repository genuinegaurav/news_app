// import 'package:flutter/material.dart';

// class BookmarksScreen extends StatelessWidget {
//   final List<String> bookmarks;

//   const BookmarksScreen({Key? key, required this.bookmarks}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bookmarks'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/bg.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: bookmarks.isEmpty
//             ? Center(
//                 child: Text(
//                   'No bookmarks yet.',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: bookmarks.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       bookmarks[index],
//                       style: TextStyle(
//                           color: Colors
//                               .white), // Ensures text is visible on the background
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bookmark_service.dart';

class BookmarksScreen extends StatefulWidget {
  final List<Map<String, dynamic>> bookmarks;
  final Function(int) removeBookmark;

  const BookmarksScreen({
    Key? key,
    required this.bookmarks,
    required this.removeBookmark,
  }) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late List<Map<String, dynamic>> _bookmarks;

  @override
  void initState() {
    super.initState();
    _bookmarks = List.from(widget.bookmarks);
  }

  void _handleDelete(int index) async {
    // Remove bookmark from the service
    final bookmark = _bookmarks[index];
    await BookmarkService().removeBookmark(bookmark['link']!);

    // Update local state
    setState(() {
      _bookmarks.removeAt(index);
    });

    // Inform the parent widget about the removal
    widget.removeBookmark(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _bookmarks.isEmpty
            ? Center(
                child: Text(
                  'No bookmarks yet.',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = _bookmarks[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    color: Colors.grey[800], // Improved readability
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(
                        bookmark['title'] ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: bookmark['imgUrl'] != null
                          ? Image.network(
                              bookmark['imgUrl']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : null,
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _handleDelete(index),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              url: bookmark['link']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
