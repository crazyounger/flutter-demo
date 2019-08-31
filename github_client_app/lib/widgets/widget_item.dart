import 'package:flutter/material.dart';

String _widgetName;
const int borderColor = 0xcccccc;

class WidgetItem extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  final int index; //用于计算border
  final int totalCount;
  final int rowLength;
  final String textSize;

  WidgetItem({
    this.title,
    this.onTap,
    this.index,
    this.totalCount,
    this.rowLength,
    this.textSize
  });

  @override
  Widget build(BuildContext context) {
    _widgetName = title.replaceFirst(title.substring(0,1), title.substring(0,1).toUpperCase());
    Icon widgetIcon;
    widgetIcon = Icon(Icons.crop);
    TextStyle style = TextStyle(fontSize: 13.8, );
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: _buildBorder(context)
        ),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            widgetIcon,
            SizedBox(
              height: 8.0,
            ),
            Text(
              _widgetName,
              style: style,
            )
          ],
        ),
      ),
    );
  }

  Border _buildBorder(BuildContext context){
    Border _border;
    bool isRight = (index % rowLength) == (rowLength - 1); //是不是最右边的,决定是否有右侧边框
    var currentRow = (index + 1) % rowLength > 0
        ? (index + 1) ~/ rowLength + 1
        : (index + 1) ~/ rowLength;
    int totalRow = totalCount % rowLength > 0
        ? totalCount ~/ rowLength + 1
        : totalCount ~/ rowLength;
    if (currentRow < totalRow && isRight) {
      //不是最后一行,是最右边
      _border = Border(
        bottom:  BorderSide(
            width: 1.0, color:  Colors.grey[100]),
      );
    }
    if (currentRow < totalRow && !isRight) {
      _border = Border(
        right:  BorderSide(
            width: 1.0, color: Colors.grey[100]),
        bottom:  BorderSide(
            width: 1.0, color: Colors.grey[100]),
      );
    }
    if (currentRow == totalRow && !isRight) {
      _border = Border(
        right:  BorderSide(
            width: 1.0, color: Colors.grey[100]),
      );
    }
    return _border;
  }
}