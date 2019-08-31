import 'package:flutter/material.dart';
import 'package:github_client_app/views/user_page/index.dart';
import 'package:github_client_app/views/widget_page/index.dart';
import 'package:github_client_app/views/about_page/index.dart';
import 'package:github_client_app/widgets/search_input.dart';

class AppPage extends StatefulWidget {

  @override
  _AppPageState createState() => new _AppPageState();
}

class _AppPageState extends State<AppPage> {

  final List<Widget> _list = List();
  int _currentIndex = 0;
  List tabDatas = [
    {'text': 'WIDGET', 'icon': Icon(Icons.extension)},
    {'text': '关于手册', 'icon': Icon(Icons.import_contacts)},
    {'text': '个人中心', 'icon': Icon(Icons.account_circle)},
  ];
  List<BottomNavigationBarItem> _myTabs = [];


  @override
  void initState() {
    super.initState();
    for(int i = 0;i < tabDatas.length ; i++){
      var icon = tabDatas[i]['icon'];
      var text = tabDatas[i]['text'];
      _myTabs.add(BottomNavigationBarItem(icon: icon,title:Text(text)));
    }
    _list
      ..add(WidgetPage())
      ..add(AboutPage())
      ..add(UserPage());
  }

  void _itemTapped(int index){
      setState(() {
        _currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: _buildAppbar(context),
      body:IndexedStack(
        index: _currentIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        currentIndex: _currentIndex,
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildAppbar(BuildContext context){
    return AppBar(
      title: buildSearchInput(context),
    );
  }

  Widget buildSearchInput(BuildContext context){
    return new SearchInput();
  }
}