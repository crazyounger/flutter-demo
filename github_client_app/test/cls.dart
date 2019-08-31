import 'dart:math';

void main(List<String> args){
//  var bicycle = new Bicycle(100, 10);
//  print(bicycle);
//  bicycle.speedUp(20);
//  print(bicycle);
//  bicycle.speedUp(200);
//  print(bicycle);
//  bicycle.applyBrake(100);
//  print(bicycle);

//  print(Rectangle(origin: const Point(10, 20),width: 20,height: 20));
//  print(Rectangle(width: 20));
//  print(Rectangle(height: 100));

  print(Shape('circle'));
  print(Shape('square'));
}

class Bicycle {
  int cadence;
  int _speed = 0;
  int gear;

  Bicycle(this.cadence,this.gear);

  int get speed => _speed;

  void applyBrake(int decrement){
    _speed -= decrement;
  }

  void speedUp(int increment){
    _speed += increment;
  }



  @override
  String toString() {
    return 'Bicycle $_speed mph';
  }
}

class Rectangle{

  Rectangle({this.origin = const Point(0,0),this.width =0 ,this.height=0});

  Point origin;
  int width;
  int height ;

  @override
  String toString() {
    return  'Origin: (${origin.x}, ${origin.y}), width: $width, height: $height';
  }
}

abstract class Shape{
  num get area;

  factory Shape(String type){
    if(type == 'circle') return Circle(10);
    if(type == 'square') return Square(4);
    throw "Can't create $type";
  }

  @override
  String toString() {
    return "shape area $area";
  }
}

class Circle implements Shape{
  final num radius;
  Circle(this.radius);
  num get area => pi * pow(radius, 2);

  @override
  String toString() {
    return "circle area ${area.toStringAsFixed(2)}";
  }
}

class Square implements Shape {
  final num side;
  Square(this.side);
  num get area => pow(side, 2);

  @override
  String toString() {
    return "square area $area";
  }
}

Shape shapeFactory(String type){
  if(type == 'circle'){
    return Circle(2);
  }else if(type == 'square'){
    return Square(5);
  }else{
    throw 'Can\'t create $type.';
  }
}

class CircleMock implements Circle{
  num area;
  num radius;
}