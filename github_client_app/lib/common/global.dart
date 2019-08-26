import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = new Profile();

//  static NetCache netCache = new NetCache();
  static List<MaterialColor> get themes => _themes;
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if(_profile != null){
      try{
        profile = Profile.fromJson(json.decode(_profile));
      }catch(e){
        print(e);
      }
    }
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    //初始化网络请求相关
//    Git.init();
  }

  static saveProfile() =>
      _prefs.setString('profile', json.encode(profile.toJson()));
}
