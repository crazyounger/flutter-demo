import 'dart:collection';
import 'package:dio/dio.dart';
import '../index.dart';

class CacheObject {
  CacheObject(this.response):
      timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other){
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;

}

class NetCache extends Interceptor{

  var cache = LinkedHashMap<String,CacheObject>();

  @override
  onRequest(RequestOptions options){
    if(!Global.profile.cache.enable) return options;
    bool refresh = options.extra['refresh'] == true;
    if(refresh){
      if(options.extra['list'] == true){
        cache.removeWhere((key,value)=> key.contains(options.path));
      }else{
        delete(options.uri.toString());
      }
      return options;
    }
    if(options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get'){
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];
      if(ob != null){
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
  }

  @override
  onError(DioError err) {
    // 错误状态不缓存
  }

  @override
  onResponse(Response response) {
    // 如果启用缓存，将返回结果保存到缓存
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response object) {
    RequestOptions options = object.request;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
