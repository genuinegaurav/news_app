import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    routes: {
      '/home': (context) => HomeScreen(), // Define your HomeScreen here
    },
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isCreatingNewProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreatingNewProfile ? 'Create New Profile' : 'Login'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(_usernameController, 'Username', false),
            SizedBox(height: 26),
            _buildTextField(_passwordController, 'Password', true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  _showError('Please enter both username and password.');
                  return;
                }

                if (_isCreatingNewProfile) {
                  await _createProfile();
                } else {
                  await _login();
                }
              },
              child: Text(
                _isCreatingNewProfile ? 'Create Profile' : 'Login',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isCreatingNewProfile = !_isCreatingNewProfile;
                });
              },
              child: Text(
                _isCreatingNewProfile
                    ? 'Already have an account? Login'
                    : 'Create a new profile',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              },
              child:
                  Text('Edit Profile', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, bool obscureText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Future<void> _createProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (prefs.getString(username) != null) {
      _showError(
          'Username already exists. Please choose a different username.');
      return;
    }

    await prefs.setString(username, password);
    await prefs.setBool('isLoggedIn', true);
    _showSuccess('Profile created successfully! You can now log in.');
  }

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    final savedPassword = prefs.getString(username);

    if (savedPassword == null) {
      _showError('Username does not exist. Please create a new profile.');
      return;
    }

    if (savedPassword != password) {
      _showError('Incorrect password. Please try again.');
      return;
    }

    await prefs.setBool('isLoggedIn', true);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _currentUsernameController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_currentUsernameController, 'Username', false),
            SizedBox(height: 16),
            _buildTextField(
                _currentPasswordController, 'Current Password', true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showUpdateOptions();
              },
              child: Text('Proceed', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, bool obscureText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
        obscureText: obscureText,
      ),
    );
  }

  void _showUpdateOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUsername = _currentUsernameController.text;
    final currentPassword = _currentPasswordController.text;

    final savedPassword = prefs.getString(currentUsername);

    if (savedPassword == null || savedPassword != currentPassword) {
      _showError('Incorrect username or password. Please try again.');
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Update Username'),
              onTap: () {
                Navigator.pop(context);
                _showUsernameUpdateDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Update Password'),
              onTap: () {
                Navigator.pop(context);
                _showPasswordUpdateDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUsernameUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Username'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_newUsernameController, 'New Username', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _updateUsername();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_newPasswordController, 'New Password', true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _updatePassword();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final newUsername = _newUsernameController.text;
    final currentUsername = _currentUsernameController.text;
    final currentPassword = _currentPasswordController.text;

    if (newUsername.isEmpty) {
      _showError('New username cannot be empty.');
      return;
    }

    if (prefs.getString(newUsername) != null) {
      _showError(
          'New username already exists. Please choose a different username.');
      return;
    }

    final savedPassword = prefs.getString(currentUsername);
    if (savedPassword != currentPassword) {
      _showError('Current password is incorrect.');
      return;
    }

    await prefs.setString(newUsername, savedPassword!);
    await prefs.remove(currentUsername);
    _showSuccess('Username updated successfully!');
  }

  Future<void> _updatePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final newPassword = _newPasswordController.text;
    final currentUsername = _currentUsernameController.text;
    final currentPassword = _currentPasswordController.text;

    if (newPassword.isEmpty) {
      _showError('New password cannot be empty.');
      return;
    }

    final savedPassword = prefs.getString(currentUsername);
    if (savedPassword != currentPassword) {
      _showError('Current password is incorrect.');
      return;
    }

    await prefs.setString(currentUsername, newPassword);
    _showSuccess('Password updated successfully!');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
