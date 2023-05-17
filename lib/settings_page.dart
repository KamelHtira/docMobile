import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkModeEnabled = value;
    });
  }

  void _logout() {
    // Implement logout functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.headline6,
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkModeEnabled,
              onChanged: _toggleTheme,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
