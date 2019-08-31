import 'package:flutter/material.dart';
import 'package:github_client_app/widgets/widget_item.dart';
import 'package:github_client_app/views/widget_page/textfield_route.dart';


class WidgetItemContainer extends StatelessWidget {

  WidgetItemContainer({
    Key key,
    this.columnCount,
    this.contentItems
  }) : super(key:key);

  final int columnCount;
  final List<String> contentItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildColumns(context)
    );
  }

  List<Widget> _buildColumns(BuildContext context){
    List<Widget> _listWidget = [];
    List<Widget> _listRows = [];

    int addI;
    for(int i = 0 ,length = contentItems.length;i < length ; i+= columnCount){
      _listRows = [];
      for(int j = 0 ; j < columnCount ; j++){
        addI = i + j;
        if(addI < length){
          String item = contentItems[addI];
          _listRows.add(
            Expanded(
              flex: 1,
              child: WidgetItem(
                title: item,
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return TextFieldRoute();
                  }));
                },
                index:addI,
                totalCount:length,
                rowLength:columnCount,
                textSize:'middle'

              ) ,
            )
          );
        }else{
          _listRows.add(Expanded(flex:1,child: Container()));
        }
      }
      _listWidget.add(Row(children: _listRows,));
    }
    return _listWidget;
  }
}

