# sp_util
[![Pub](https://img.shields.io/pub/v/sp_util.svg?style=flat-square&color=009688)](https://pub.dartlang.org/packages/sp_util)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Pub](https://img.shields.io/pub/v/sp_util.svg?style=flat-square&color=2196F3)](https://pub.flutter-io.cn/packages/sp_util)

Flutter shared_preferences plugin util, support get default value, save object, object list. Use SharedPreferences easily.

### Pub
```yaml
dependencies:
  sp_util: ^2.0.0
```

### APIs
```yaml
getObj
getObjList
putObject
getObject
putObjectList
getObjectList
getString
putString
getBool
putBool
getInt
putInt
getDouble
putDouble
getStringList
putStringList
getDynamic
haveKey
getKeys
remove
clear
reload
isInitialized
```

### Example
```yaml
/// Example One.
/// await SpUtil initialization to complete before running the app.
/// sp init time release about 30ms，debug about 100ms.(Test on Android.)
void main() async {
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
 
     /// examples
    SpUtil.putString("username", "sky24");
    String userName = SpUtil.getString("username", defValue: "");
    print("userName: " + userName);

    /// save object example.
    /// 存储实体对象示例。
    City city = City();
    city.name = "成都市";
    SpUtil.putObject("loc_city", city);

    City hisCity = SpUtil.getObj("loc_city", (v) => City.fromJson(v));
    print("City: " + (hisCity == null ? "null" : hisCity.toString()));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = List();
    list.add(City(name: "成都市"));
    list.add(City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<City> dataList = SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
    print("CityList: " + (dataList == null ? "null" : dataList.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}  


/// Example Two.
/// add SplashPage, complete sp initialization on the SplashPage. Then you can use it synchronously to the homepage。
...
...
```

### More Util
[common_utils](https://github.com/Sky24n/common_utils) Dart common utils.
1. TimelineUtil     : timeline util.
2. TimerUtil        : countdown，timer.
3. MoneyUtil        : fen to yuan, format output.
4. LogUtil          : simply encapsulate print logs.
5. DateUtil         : date conversion formatted output.
6. RegexUtil        : regular verification of mobile phone numbers, ID cards, mailboxes and so on.
7. NumUtil          : keep [x] decimal places, add subtract multiply divide without loosing precision.
8. ObjectUtil       : object is empty, two List is equal.
9. EncryptUtil      : xor, md5 ，Base64..
10. TextUtil        : hide phoneNo.
11. JsonUtil        : json to object.

[flustars](https://github.com/Sky24n/flustars) Flutter common utils.
1. SpUtil           : SharedPreferences Util.
2. ScreenUtil       : get screen width height density, appBarHeight, statusBarHeight, orientation.
3. WidgetUtil       : get Widget width height，coordinates.
4. ImageUtil        : get image size.
5. DirectoryUtil    : Directory Util.

```yaml
dependencies:
  # https://github.com/Sky24n/common_utils
  common_utils: ^1.2.1
  # https://github.com/Sky24n/flustars
  flustars: ^0.3.3
  # https://github.com/Sky24n/sp_util
  sp_util: ^2.0.0
```

## Changelog

Please see the [Changelog](CHANGELOG.md) page to know what's recently changed.