import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

import 'models.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    /// 同步使用Sp。
    SpUtil.remove("username");
    String defName = SpUtil.getString("username", defValue: "sky");
    SpUtil.putString("username", "sky24");
    String name = SpUtil.getString("username");
    print("MyApp defName: $defName, name: $name");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/MainPage': (ctx) => MyHomePage(),
      },
      home: SplashPage(),
    );
  }
}

/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _info = '';

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
    Future.delayed(Duration(milliseconds: 500), () {
      /// 同步使用Sp。
      /// 是否显示引导页。
      if (SpUtil.getBool("key_guide", defValue: true)) {
        SpUtil.putBool("key_guide", false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  /// App引导页逻辑。
  void _initBanner() {
    setState(() {
      _info = "引导页～";
    });
  }

  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _info = "广告页，2秒后跳转到主页";
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed('/MainPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: Center(
        child: Text("$_info"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isGuide = SpUtil.getBool("key_guide", defValue: true);
          if (isGuide) {
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    /// 同步使用Sp。

    /// 存取基础类型
    SpUtil.putString("username", "Sky24n");
    String userName = SpUtil.getString("username");
    print("MyHomePage userName: " + userName);

    bool isFirst = SpUtil.getBool("userName", defValue: true);
    SpUtil.putBool("isFirst", false);
    print("MyHomePage isFirst: $isFirst");

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

    List<City> _cityList =
        SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
    print("City list: " + (_cityList == null ? "null" : _cityList.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text(SpUtil.getString("username")),
      ),
    );
  }
}
