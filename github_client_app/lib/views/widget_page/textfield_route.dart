import 'package:flutter/material.dart';

class TextFieldRoute extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField Demo'),
      ),
      body: Container(
        height: 400.0,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('show how to use textfield...'),
            TextField(
              controller: _controller,
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              readOnly: false,
              enabled: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '用户名:',
                labelStyle: TextStyle(
                  color: Colors.red[300],
                  fontSize: 24.0
                ),
                hintText: '输入6-12位数字组合',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0
                ),
                prefixIcon: Icon(Icons.phone),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2979FF)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2979FF)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              maxLength: 100,
              maxLines: 1,
//              textInputAction: TextInputAction.done,
              style: TextStyle(
                color: Colors.red[300],
                fontStyle: FontStyle.normal,
                fontSize: 22.0
              ),
              textAlign: TextAlign.center,
              autofocus: true,
//              obscureText: true,
              cursorColor: Colors.red[300],
              cursorWidth: 2,
            )
          ],
        ),
      )
    );
  }

  void _onChanged(String value){
    print('onChanged  , $value');
  }

  void _onSubmitted(String value){
    print('onSubmitted  , $value');
    print('get content from controller , ${_controller.text}');
    _controller.text = 'hello,world';
  }
}