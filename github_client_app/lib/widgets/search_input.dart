import 'package:flutter/material.dart';


typedef Future<List<String>> MaterialSearchFinder(String search);

class SearchInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0,left: 10.0,top: 3.0),
            child: Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
              size: 24.0,
            ),
          ),
          new Expanded(
            child: new MaterialSearchInput(
              placeholder:'搜索flutter组件',
              getResults:null
            )
          ),
        ],
      ),
    );
  }
}

class MaterialSearchInput<T> extends StatefulWidget {

  MaterialSearchInput({
    this.placeholder,
    this.getResults
  });

  final String placeholder;
  final MaterialSearchFinder getResults;

  @override
  MaterialSearchInputState createState() => new MaterialSearchInputState<T>();
}

class MaterialSearchInputState<T> extends State<MaterialSearchInput<T>>{
  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.subhead;
    return new InkWell(
      onTap: _onTap,
      child: new FormField(
          builder: (FormFieldState<T> field){
            return new InputDecorator(
              isEmpty: _isEmpty(field),
              decoration: InputDecoration(
                labelText: widget.placeholder,
                border: InputBorder.none,
                errorText: field.errorText
              ),
              child: _isEmpty(field)
               ? null
               : new Text(
                 field.value.toString(),
                 style: valueStyle,
               ),
            );
          },
      ),
    );
  }

  bool _isEmpty(field){
    return field.value == null;
  }

  _onTap(){
    print('onTap');
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('search input clicked!')));
  }
}

