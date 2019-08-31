import 'package:flutter/material.dart';
import 'package:github_client_app/widgets/cate_card.dart';

var  widgetDatas = {
  "element":[
    "Form","Frame","Media"
  ],
  "components":[
    "Navigation","List","Card",
    "Bar","Dialog","Scaffold",
    "Grid","Scroll","Tab","Menu",
    "Pick","Chip","Panel","progress"
  ],
  "themes":[
    "material","cupertino"
  ]
};

class WidgetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        color:Theme.of(context).backgroundColor,
        child: buildGrid(context)
    );
  }

  Widget buildGrid(BuildContext context){
    List<Widget> tiles = [];
    widgetDatas.forEach((String name,List<String> items){
      tiles.add(CateCard(name: name,items: items,));
    });
    return ListView(children: tiles);
  }
}


