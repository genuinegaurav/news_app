// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as html_parser;
// import 'package:html/dom.dart' as dom;
// import 'package:webview_flutter/webview_flutter.dart';

// class SportsScreen extends StatefulWidget {
//   @override
//   _SportsScreenState createState() => _SportsScreenState();
// }

// class _SportsScreenState extends State<SportsScreen> {
//   List<Map<String, String>> articles = [];
//   bool isLoading = true;
//   bool isLoadingMore = false;
//   int currentPage = 0;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     fetchSportsNews();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollListener() {
//     if (_scrollController.position.extentAfter < 500 && !isLoadingMore) {
//       fetchMoreSportsNews();
//     }
//   }

//   Future<void> fetchSportsNews() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://news.google.com/topics/CAAqKggKIiRDQkFTRlFvSUwyMHZNRFp1ZEdvU0JXVnVMVWRDR2dKSlRpZ0FQAQ?hl=en-IN&gl=IN&ceid=IN%3Aen'));

//       if (response.statusCode == 200) {
//         dom.Document document = html_parser.parse(response.body);
//         final elements = document.querySelectorAll('article');

//         final fetchedArticles = elements
//             .map((element) {
//               final anchorElement = element.querySelector('a.gPFEn');
//               final title = anchorElement?.text ?? '';
//               final link = anchorElement != null
//                   ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
//                   : '';

//               if (title.isNotEmpty && link.isNotEmpty) {
//                 return {
//                   'title': title,
//                   'link': link,
//                 };
//               } else {
//                 return null;
//               }
//             })
//             .where((article) => article != null)
//             .cast<Map<String, String>>()
//             .toList();

//         setState(() {
//           articles = fetchedArticles;
//           isLoading = false;
//         });

//         for (int i = 0; i < articles.length; i++) {
//           final imgUrl = await fetchArticleImage(
//               articles[i]['link']!, articles[i]['title']!);
//           setState(() {
//             articles[i]['imgUrl'] = imgUrl;
//           });
//         }
//       } else {
//         throw Exception('Failed to load sports news');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print(e);
//     }
//   }

//   Future<void> fetchMoreSportsNews() async {
//     setState(() {
//       isLoadingMore = true;
//     });

//     try {
//       final response = await http.get(Uri.parse(
//           'https://news.google.com/topics/CAAqKggKIiRDQkFTRlFvSUwyMHZNRFp1ZEdvU0JXVnVMVWRDR2dKSlRpZ0FQAQ?hl=en-IN&gl=IN&ceid=IN%3Aen&page=$currentPage'));

//       if (response.statusCode == 200) {
//         dom.Document document = html_parser.parse(response.body);
//         final elements = document.querySelectorAll('article');

//         final fetchedArticles = elements
//             .map((element) {
//               final anchorElement = element.querySelector('a.gPFEn');
//               final title = anchorElement?.text ?? '';
//               final link = anchorElement != null
//                   ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
//                   : '';

//               if (title.isNotEmpty && link.isNotEmpty) {
//                 return {
//                   'title': title,
//                   'link': link,
//                 };
//               } else {
//                 return null;
//               }
//             })
//             .where((article) => article != null)
//             .cast<Map<String, String>>()
//             .toList();

//         setState(() {
//           articles.addAll(fetchedArticles);
//           currentPage++;
//           isLoadingMore = false;
//         });

//         for (int i = articles.length - fetchedArticles.length;
//             i < articles.length;
//             i++) {
//           final imgUrl = await fetchArticleImage(
//               articles[i]['link']!, articles[i]['title']!);
//           setState(() {
//             articles[i]['imgUrl'] = imgUrl;
//           });
//         }
//       } else {
//         throw Exception('Failed to load more sports news');
//       }
//     } catch (e) {
//       setState(() {
//         isLoadingMore = false;
//       });
//       print(e);
//     }
//   }

//   Future<String> fetchArticleImage(String url, String title) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         dom.Document document = html_parser.parse(response.body);
//         final imgElements = document.querySelectorAll('img');
//         for (var imgElement in imgElements) {
//           final imgTitle = imgElement.attributes['title'] ?? '';
//           final imgAlt = imgElement.attributes['alt'] ?? '';
//           final imgSrc = imgElement.attributes['src'] ?? '';
//           if (imgSrc.isNotEmpty &&
//               (imgTitle.contains(title) || imgAlt.contains(title))) {
//             return imgSrc.startsWith('http')
//                 ? imgSrc
//                 : 'https://news.google.com' + imgSrc;
//           }
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//     return '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sports News'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView.builder(
//                 controller: _scrollController,
//                 itemCount: articles.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == articles.length) {
//                     return isLoadingMore
//                         ? Center(child: CircularProgressIndicator())
//                         : SizedBox.shrink();
//                   }
//                   return Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 WebViewScreen(url: articles[index]['link']!),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (articles[index]['imgUrl']?.isNotEmpty ?? false)
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                               child: Image.network(
//                                 articles[index]['imgUrl']!,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                                 width: double.infinity,
//                                 loadingBuilder:
//                                     (context, child, loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Center(
//                                       child: CircularProgressIndicator());
//                                 },
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: Colors.grey,
//                                     height: 200,
//                                     width: double.infinity,
//                                   );
//                                 },
//                               ),
//                             ),
//                           if (articles[index]['title']!.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 articles[index]['title']!,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

// class WebViewScreen extends StatelessWidget {
//   final String url;

//   WebViewScreen({required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Article'),
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
