// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class BookmarkService {
//   Future<void> addBookmark(
//       String title, String link, String imgUrl, String description) async {
//     final prefs = await SharedPreferences.getInstance();
//     final bookmarks = prefs.getStringList('bookmarks') ?? [];

//     final newBookmark = {
//       'title': title,
//       'link': link,
//       'imgUrl': imgUrl,
//       'description': description,
//     };

//     bookmarks.add(json.encode(newBookmark));
//     await prefs.setStringList('bookmarks', bookmarks);
//   }

//   Future<List<Map<String, dynamic>>> getBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final bookmarks = prefs.getStringList('bookmarks') ?? [];

//     return bookmarks.map((bookmark) {
//       final Map<String, dynamic> decodedBookmark = json.decode(bookmark);
//       return decodedBookmark;
//     }).toList();
//   }

//   Future<void> removeBookmark(String link) async {
//     final prefs = await SharedPreferences.getInstance();
//     final bookmarks = prefs.getStringList('bookmarks') ?? [];

//     bookmarks.removeWhere((bookmark) {
//       final Map<String, dynamic> decodedBookmark = json.decode(bookmark);
//       return decodedBookmark['link'] == link;
//     });

//     await prefs.setStringList('bookmarks', bookmarks);
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkService {
  Future<void> addBookmark(
      String title, String link, String imgUrl, String description) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarks') ?? [];

    final newBookmark = {
      'title': title,
      'link': link,
      'imgUrl': imgUrl,
      'description': description,
    };

    // Check if the bookmark already exists
    final existingBookmarks = bookmarks.map((bookmark) {
      final Map<String, dynamic> decodedBookmark = json.decode(bookmark);
      return decodedBookmark['link'];
    }).toSet();

    if (!existingBookmarks.contains(link)) {
      bookmarks.add(json.encode(newBookmark));
      await prefs.setStringList('bookmarks', bookmarks);
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarks') ?? [];

    return bookmarks.map((bookmark) {
      try {
        final Map<String, dynamic> decodedBookmark = json.decode(bookmark);
        // Ensure the type is List<Map<String, dynamic>>
        return decodedBookmark.cast<String, dynamic>();
      } catch (e) {
        // Handle error during decoding
        print('Error decoding bookmark: $e');
        return <String, dynamic>{};
      }
    }).toList();
  }

  Future<void> removeBookmark(String link) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarks') ?? [];

    final updatedBookmarks = bookmarks.where((bookmark) {
      final Map<String, dynamic> decodedBookmark = json.decode(bookmark);
      return decodedBookmark['link'] != link;
    }).toList();

    if (updatedBookmarks.length != bookmarks.length) {
      await prefs.setStringList('bookmarks', updatedBookmarks);
    }
  }
}
