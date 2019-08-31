import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

Future<String> loadConfig() async{
  return await rootBundle.loadString('jsons/cacheConfig.json');
}



void main() {
  runApp(MyApp());
  loadConfig().then((String config){
    print(config);
  });
}

class MyApp extends StatelessWidget {

  Widget _buildBody(){
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.add),
                Container(
                  child: Text('ADD'),
                  margin: const EdgeInsets.only(top: 10.0),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.favorite),
                Container(
                  child: Text('FAVORITE'),
                  margin: const EdgeInsets.only(top: 10.0),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.remove),
                Container(
                  child: Text('REMOVE'),
                  margin: const EdgeInsets.only(top: 10.0),
                )
              ],
            )
          ],
        )
    );
  }
  
  Widget _buildBody1(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('imgs/logo_dark.png',fit: BoxFit.contain,width: 100.0),
          Text('logo_dark.png'),
        ],
      ),
    );
  }

  Widget _buildBody2(){
    return ListView(
      children: <Widget>[
        _buildImage(),
        _buildTitleSection(),
        _buildButtonSection(),
        _buildTextSeciton()
      ],
    );
  }

  Color color = Colors.blueAccent[400];
  
  Widget _buildTextSeciton(){
    return Container(
      padding: const EdgeInsets.all(18),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    )  ;
  }
  
  Widget _buildButtonSection(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE')
        ],
      ),
    );
  }

  Widget _buildButtonColumn(Color color,IconData icon,String label){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon,color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color
            ),
          ),
        )
      ],

    );
  }

  Widget _buildTitleSection(){
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41')
        ],
      ),
    );
  }

  Widget _buildImage(){
    return Image.network(
      'https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg',
      height: 240,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Layout Learn',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Layout'),
        ),
        body: _buildBody2(),
      ),
    );
  }
}