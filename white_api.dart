// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as html_parser;
// import 'package:html/dom.dart' as dom;
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

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
//               final imgElement = element.querySelector('img');

//               final title = anchorElement?.text ?? '';
//               final link = anchorElement != null
//                   ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
//                   : '';

//               final imgUrl = imgElement?.attributes['src'] ?? '';

//               if (title.isNotEmpty && imgUrl.isNotEmpty) {
//                 return {
//                   'title': title,
//                   'link': link,
//                   'imgUrl': imgUrl.startsWith('http')
//                       ? imgUrl
//                       : 'https://news.google.com' + imgUrl,
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
//               final imgElement = element.querySelector('img');

//               final title = anchorElement?.text ?? '';
//               final link = anchorElement != null
//                   ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
//                   : '';

//               final imgUrl = imgElement?.attributes['src'] ?? '';

//               if (title.isNotEmpty && imgUrl.isNotEmpty) {
//                 return {
//                   'title': title,
//                   'link': link,
//                   'imgUrl': imgUrl.startsWith('http')
//                       ? imgUrl
//                       : 'https://news.google.com' + imgUrl,
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
//                       onTap: () async {
//                         final article = articles[index];
//                         final summary = await getSummary(article['link']!);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ArticleScreen(
//                               title: article['title']!,
//                               imgUrl: article['imgUrl']!,
//                               summary: summary,
//                               fullUrl: article['link']!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (articles[index]['imgUrl']!.isNotEmpty)
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

//   Future<String> getSummary(String url) async {
//     final apiKey = dotenv.env['OPENAI_API_KEY']!;
//     final apiUrl =
//         'https://api.openai.com/v1/engines/davinci-codex/completions';
//     final headers = {
//       'Authorization': 'Bearer $apiKey',
//       'Content-Type': 'application/json',
//     };
//     final body = {
//       'prompt': 'Summarize the following text:\n$url',
//       'max_tokens': 150,
//       'temperature': 0.5,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         return responseData['choices'][0]['text'].trim();
//       } else {
//         throw Exception('Failed to summarize text');
//       }
//     } catch (e) {
//       print(e);
//       return 'Failed to summarize the article.';
//     }
//   }
// }

// class ArticleScreen extends StatelessWidget {
//   final String title;
//   final String imgUrl;
//   final String summary;
//   final String fullUrl;

//   ArticleScreen({
//     required this.title,
//     required this.imgUrl,
//     required this.summary,
//     required this.fullUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imgUrl.isNotEmpty)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   imgUrl,
//                   fit: BoxFit.cover,
//                   height: 200,
//                   width: double.infinity,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(child: CircularProgressIndicator());
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey,
//                       height: 200,
//                       width: double.infinity,
//                     );
//                   },
//                 ),
//               ),
//             SizedBox(height: 16),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               summary,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => WebViewScreen(url: fullUrl),
//                   ),
//                 );
//               },
//               child: Text('Read Full Article'),
//             ),
//           ],
//         ),
//       ),
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
