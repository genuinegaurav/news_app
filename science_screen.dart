import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'background_widget.dart'; // Import the background widget
import 'bookmark_service.dart'; // Import the bookmark service

class ScienceScreen extends StatefulWidget {
  final bool isDarkMode;

  ScienceScreen({required this.isDarkMode});

  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> articles = [];
  Set<String> bookmarkedArticles = Set();
  bool isLoading = true;
  bool isLoadingMore = false;
  int currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchScienceNews();
    _scrollController.addListener(_scrollListener);
    loadBookmarkedArticles();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !isLoadingMore) {
      fetchMoreScienceNews();
    }
  }

  Future<void> loadBookmarkedArticles() async {
    List<Map<String, dynamic>> bookmarks =
        await BookmarkService().getBookmarks();
    setState(() {
      bookmarkedArticles =
          bookmarks.map((bookmark) => bookmark['link'] as String).toSet();
    });
  }

  Future<void> fetchScienceNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://news.google.com/topics/CAAqKggKIiRDQkFTRlFvSUwyMHZNRFp0Y1RjU0JXVnVMVWRDR2dKSlRpZ0FQAQ?hl=en-IN&gl=IN&ceid=IN%3Aen'));

      if (response.statusCode == 200) {
        dom.Document document = html_parser.parse(response.body);
        final elements = document.querySelectorAll('article');

        final fetchedArticles = elements
            .map((element) {
              final anchorElement = element.querySelector('a.gPFEn');
              final imgElement = element.querySelector('img[loading="lazy"]');
              final h1Element = element.querySelector('h1');
              final descriptionDiv =
                  h1Element?.nextElementSibling?.querySelector('div');

              final title = anchorElement?.text ?? '';
              final link = anchorElement != null
                  ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
                  : '';

              final imgUrl = imgElement?.attributes['src'] ?? '';
              final description = descriptionDiv?.text.trim() ??
                  generateCustomDescription(title);

              if (title.isNotEmpty && imgUrl.isNotEmpty) {
                return {
                  'title': title,
                  'link': link,
                  'imgUrl': imgUrl.startsWith('http')
                      ? imgUrl
                      : 'https://news.google.com' + imgUrl,
                  'description': description,
                };
              } else {
                return null;
              }
            })
            .where((article) => article != null)
            .cast<Map<String, dynamic>>()
            .toList();

        setState(() {
          articles = fetchedArticles;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load science news');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Future<void> fetchMoreScienceNews() async {
    setState(() {
      isLoadingMore = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://news.google.com/topics/CAAqKggKIiRDQkFTRlFvSUwyMHZNRFp0Y1RjU0JXVnVMVWRDR2dKSlRpZ0FQAQ?hl=en-IN&gl=IN&ceid=IN%3Aen&page=$currentPage'));

      if (response.statusCode == 200) {
        dom.Document document = html_parser.parse(response.body);
        final elements = document.querySelectorAll('article');

        final fetchedArticles = elements
            .map((element) {
              final anchorElement = element.querySelector('a.gPFEn');
              final imgElement = element.querySelector('img[loading="lazy"]');
              final h1Element = element.querySelector('h1');
              final descriptionDiv =
                  h1Element?.nextElementSibling?.querySelector('div');

              final title = anchorElement?.text ?? '';
              final link = anchorElement != null
                  ? 'https://news.google.com${anchorElement.attributes['href']?.substring(1)}'
                  : '';

              final imgUrl = imgElement?.attributes['src'] ?? '';
              final description = descriptionDiv?.text.trim() ??
                  generateCustomDescription(title);

              if (title.isNotEmpty && imgUrl.isNotEmpty) {
                return {
                  'title': title,
                  'link': link,
                  'imgUrl': imgUrl.startsWith('http')
                      ? imgUrl
                      : 'https://news.google.com' + imgUrl,
                  'description': description,
                };
              } else {
                return null;
              }
            })
            .where((article) => article != null)
            .cast<Map<String, dynamic>>()
            .toList();

        setState(() {
          articles.addAll(fetchedArticles);
          currentPage++;
          isLoadingMore = false;
        });
      } else {
        throw Exception('Failed to load more science news');
      }
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });
      print(e);
    }
  }

  String generateCustomDescription(String title) {
    return 'Here’s what you need to know about: $title';
  }

  void showDescriptionDialog(String description, String link) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Article Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(url: link),
                          ),
                        );
                      },
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toggleBookmark(
      String title, String link, String imgUrl, String description) {
    setState(() {
      if (bookmarkedArticles.contains(link)) {
        BookmarkService().removeBookmark(link);
        bookmarkedArticles.remove(link);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bookmark removed')),
        );
      } else {
        BookmarkService().addBookmark(title, link, imgUrl, description);
        bookmarkedArticles.add(link);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Article bookmarked!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Ensure background color is transparent
      body: BackgroundWidget(
        isDarkMode: false,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: fetchScienceNews,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: articles.length + 1,
                    itemBuilder: (context, index) {
                      if (index == articles.length) {
                        return isLoadingMore
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox.shrink();
                      }
                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        color:
                            widget.isDarkMode ? Colors.grey[800] : Colors.white,
                        child: InkWell(
                          onTap: () {
                            showDescriptionDialog(
                              articles[index]['description']!,
                              articles[index]['link']!,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (articles[index]['imgUrl']!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    articles[index]['imgUrl']!,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey,
                                        height: 200,
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            'Image not available',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (articles[index]['title']!.isNotEmpty)
                                      Text(
                                        articles[index]['title']!,
                                        style: TextStyle(
                                          color: widget.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: AnimatedIcon(
                                              icon: AnimatedIcons.add_event,
                                              progress: AnimationController(
                                                vsync: this,
                                                duration:
                                                    Duration(milliseconds: 300),
                                              )..forward(),
                                              color: bookmarkedArticles
                                                      .contains(articles[index]
                                                          ['link']!)
                                                  ? Colors.red
                                                  : (widget.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            onPressed: () {
                                              toggleBookmark(
                                                articles[index]['title']!,
                                                articles[index]['link']!,
                                                articles[index]['imgUrl']!,
                                                articles[index]['description']!,
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.share,
                                                color: widget.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black),
                                            onPressed: () {
                                              shareArticle(
                                                articles[index]['title']!,
                                                articles[index]['link']!,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  void shareArticle(String title, String link) {
    Share.share('$title\n$link');
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
