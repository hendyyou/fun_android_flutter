import 'package:flutter/material.dart';
import 'package:fun_android/generated/i18n.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'tree_category_page.dart';
import 'user_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(S.of(context).tab_home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(S.of(context).tab_project),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(S.of(context).tab_structure),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(S.of(context).tab_user),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

List<Widget> pages = <Widget>[
  HomePage(),
  ProjectPage(),
  TreeCategoryPage(),
  UserPage()
];
