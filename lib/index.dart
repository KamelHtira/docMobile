// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:learning_app/home_page.dart';
import 'package:learning_app/settings_page.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  int _selectedIndexBottomBar = -1;

  List<Widget> _pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    SettingsPage(),
    SettingsPage(),
    SettingsPage(),
  ];
  List<String> _Titles = [
    'Account',
    'Settings',
    'History',
    'Home',
    'Profile',
    'Search Doctors',
    'Search Doctors'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Center(
            child: Padding(
                child: Text(_Titles[_selectedIndex]),
                padding: EdgeInsets.only(right: 50))),
      ),
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //   color: Color(0xFF00846c),
        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        // ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 27,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 27,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 27,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 27,
              ),
              label: 'Notifications',
            ),
          ],
          currentIndex:
              _selectedIndexBottomBar == -1 ? 0 : _selectedIndexBottomBar,
          selectedItemColor: _selectedIndexBottomBar == -1
              ? Colors.grey[400]
              : Color(0xFF00846c),
          unselectedItemColor: Colors.grey[400],
          selectedFontSize: _selectedIndexBottomBar == -1 ? 12 : 12,
          unselectedFontSize: 12,
          selectedLabelStyle: _selectedIndexBottomBar != -1
              ? TextStyle(
                  fontWeight: FontWeight.bold,
                )
              : null,
          onTap: _onItemTappedBottomBar,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: 200,
                child: DrawerHeader(
                  child: Icon(
                    Icons.person_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF00846c),
                  ),
                )),
            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text('Account'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => Navigator.of(context).pushNamed('/login'),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    setState(() {
      _selectedIndexBottomBar = -1;
    });
  }

  void _onItemTappedBottomBar(int index) {
    setState(() {
      _selectedIndex = index + 3;
    });
    print('Hello, world!');
    setState(() {
      _selectedIndexBottomBar = index;
    });
  }

  void _logout(BuildContext context) {
    // Implement logout functionality here
  }
}
