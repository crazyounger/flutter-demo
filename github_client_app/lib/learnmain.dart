import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to App',
      theme: new ThemeData(
        primaryColor: Colors.red[500],
      ),
//      home: CsScaffold(),
      home: ShoppingList(
        products: <Product>[
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],
    ),
    );
  }
}

class CsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: new SafeArea(
          child: Column(
        children: <Widget>[
          CsAppBar(
            title: Text('hello,appbar',),
          ),
          Expanded(
            child: Center(
              child: Text(
                'hello,flutter',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
          ),
          TapContainer(
            child: Text('click me'),
            onTap: (){},
          )
        ],
      )),
    );
  }
}

class CsAppBar extends StatelessWidget {
  CsAppBar({@required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: null,
          ),
          Expanded(
            child: title,
          ),
          IconButton(icon: Icon(Icons.add),onPressed: null,)
        ],
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int idx) {
        if (idx.isOdd) {
          return Divider();
        }
        final int index = idx ~/ 2; //向下取整
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    bool saved = _saved.contains(pair);
    return new ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (saved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildSuggestions(),
      appBar: new AppBar(
        title: Text('name generate'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
        leading: new IconButton(
            icon: Icon(Icons.rotate_left),
            tooltip: 'add suggestion',
            onPressed: () {}),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return new ListTile(
              title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ));
        });
        final List<Widget> divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: new ListView(
            children: divided,
          ),
        );
      },
    ));
  }
}


class TapContainer extends StatelessWidget {

  TapContainer({@required this.onTap,this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('button clicked!!!!');
        this.onTap();
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.green[500],
        ),
        child: child,
      ),
    );
  }
}


class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product,bool inCart);

class ShoppingListItem extends StatelessWidget {

  ShoppingListItem({Product product,this.inCart,this.onCartChanged})
    : product = product, super(key:ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context){
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context){
    if(!inCart) return null;
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        onCartChanged(product,inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name,style: _getTextStyle(context),),

    );
  }
}

class ShoppingList extends StatefulWidget {

  ShoppingList({Key key,this.products}) : super(key:key);

  final List<Product> products;

  @override
  _ShoppingState createState() => new _ShoppingState();
}

class _ShoppingState extends State<ShoppingList>{

  Set<Product> _shoppingCart = Set<Product>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCartChanged(Product product,bool incart){
    setState((){
      if(incart){
        _shoppingCart.remove(product);
      }else{
        _shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        children: widget.products.map((Product product){
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}