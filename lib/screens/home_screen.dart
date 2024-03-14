import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serious_budget_app/data/repos/authentication_repository.dart';
import 'package:serious_budget_app/screens/expense_feed_screen.dart';
import 'package:serious_budget_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  final user; //only user.displayName is used atm

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const ExpenseFeedScreen(),
    const Text("B"),
    const Text("C"),
    const Text("D"),
  ];

  int _selectedTab = 0;

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _buildBottomTab(),
      body: _screens[_selectedTab],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, //Color.fromRGBO(243, 175, 77, 1),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomTab() {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        color: Colors.black, //Color.fromRGBO(243, 175, 77, 1),//Colors.black,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTabItem("Home", Icons.wysiwyg, 0),
            _buildTabItem("Insights", Icons.bar_chart, 1),
            const SizedBox(width: 48),
            _buildTabItem("Budget", Icons.pie_chart, 2),
            _buildTabItem("Shared", Icons.settings, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, IconData icon, int index) {
    return Expanded(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => _changeTab(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: _selectedTab == index ? Colors.white : Colors.grey,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: _selectedTab == index ? Colors.white : Colors.grey,
                    fontWeight: _selectedTab == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
