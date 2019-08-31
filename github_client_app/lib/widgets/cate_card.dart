import 'package:flutter/material.dart';
import 'package:github_client_app/widgets/widget_item_container.dart';


class CateCard extends StatefulWidget {

  CateCard({this.name,this.items});

  final String name ;
  final List<String> items;


  @override
  State<StatefulWidget> createState() => new _CateCardState();
}

class _CateCardState extends State<CateCard>{

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth-20,
            margin: const EdgeInsets.only(top: 30.0,bottom: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth-20,
                  padding: const EdgeInsets.only(left: 65.0,top: 3),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0
                    ),
                  ),
                ),
                _buildWidgetContainer()
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                  height: 46.0,
                  width: 46.0,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidgetContainer(){
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0,top: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('imgs/logo_light.png'),
          alignment: Alignment.bottomRight
        )
      ),
      child: WidgetItemContainer(
        contentItems:widget.items,
        columnCount:3
      ),
    );
  }
}