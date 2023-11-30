
import 'package:advance_flutter/data/network/network_handler.dart';

import '../response/responses.dart';
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60* 1000;


abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

Future<void> saveHomeToCache(HomeResponse homeResponse);

void clearCache();
void removeFromCache(String key);
}

 class LocalDataSourceImpl extends LocalDataSource{

  // run time cache
   Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData()async{
   CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

   if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
     // return the response from cache
     return cachedItem.data;
   }else {
    // return an error , cache is not there or it's not valid
              throw ErrorHandler.handle(DataSource.BAD_REQUEST);
   }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async{
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }


 }

 class CachedItem{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
 }
extension CachedItemExtentsion on CachedItem{
  bool isValid(int expirationTimeInMills){
    int currentTimeInMills = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMills - cacheTime <= expirationTimeInMills;

    return isValid;
  }

}