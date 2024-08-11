import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'sports_screen.dart';
import 'entertainment_screen.dart';
import 'india_screen.dart';
import 'world_screen.dart';
import 'local_screen.dart';
import 'business_screen.dart';
import 'technology_screen.dart';
import 'science_screen.dart';
import 'bookmark_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  bool _isLoggedIn = false;
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
    if (_isLoggedIn) {
      _loadBookmarks();
    }
  }

  Future<void> _loadBookmarks() async {
    BookmarkService bookmarkService = BookmarkService();
    List<Map<String, dynamic>> bookmarks = await bookmarkService.getBookmarks();
    setState(() {
      _bookmarks = bookmarks;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('isLoggedIn'); // Remove the login status
    setState(() {
      _isLoggedIn = false;
    });
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIformed',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[900],
                iconTheme: IconThemeData(color: Colors.white),
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white70),
                titleLarge: TextStyle(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey[850],
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.white70,
                elevation: 5,
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black54),
                titleLarge: TextStyle(color: Colors.black),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey[200],
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black54,
                elevation: 5,
              ),
            ),
      home: _isLoggedIn
          ? MyHomePage(
              onThemeToggle: _toggleTheme,
              isDarkMode: _isDarkMode,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              pageController: _pageController,
              bookmarks: _bookmarks,
              onBookmarksUpdated: _loadBookmarks,
              onLogout: _logout, // Pass the logout function to the home page
            )
          : LoginScreen(), // Set the login screen as the initial screen
      routes: {
        '/login': (context) => LoginScreen(), // Define the login route
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final List<Map<String, dynamic>> bookmarks;
  final VoidCallback onBookmarksUpdated;
  final VoidCallback onLogout;

  const MyHomePage({
    Key? key,
    required this.onThemeToggle,
    required this.isDarkMode,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageController,
    required this.bookmarks,
    required this.onBookmarksUpdated,
    required this.onLogout,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alertify'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: PageView(
        controller: widget.pageController,
        onPageChanged: (index) {
          widget.onItemTapped(index);
        },
        children: [
          HomeScreenWidget(
            addBookmark:
                (String title, String link, String imgUrl, String description) {
              // Implement your add bookmark logic here
            },
            bookmarks: widget.bookmarks,
            onBookmarksUpdated: widget.onBookmarksUpdated,
            user: null,
            username: '',
          ),
          SportsScreen(isDarkMode: widget.isDarkMode),
          EntertainmentScreen(isDarkMode: widget.isDarkMode),
          IndiaScreen(isDarkMode: widget.isDarkMode),
          WorldScreen(isDarkMode: widget.isDarkMode),
          LocalScreen(isDarkMode: widget.isDarkMode),
          BusinessScreen(isDarkMode: widget.isDarkMode),
          TechnologyScreen(isDarkMode: widget.isDarkMode),
          ScienceScreen(isDarkMode: widget.isDarkMode),
        ],
        pageSnapping: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Sports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Entertainment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'India',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'World',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Local',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Technology',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science,
                size: 24,
                color: widget.isDarkMode ? Colors.blueAccent : Colors.blue),
            label: 'Science',
          ),
        ],
      ),
    );
  }
}
