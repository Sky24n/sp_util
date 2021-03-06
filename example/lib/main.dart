import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

import 'example2.dart';
import 'models.dart';

/// Example One.
/// await sp initialization to complete before running the app.
/// sp init time release about 30ms，debug about 100ms.(Test on Android.)
//  int old = DateTime.now().millisecondsSinceEpoch;
//  await SpUtil.getInstance();
//  int now = DateTime.now().millisecondsSinceEpoch;
//  LogUtil.e('sp init time: ${now - old}');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

/// Example Two.
void main2() {
  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String spLastCounter = 'last_counter';

  void _incrementCounter() {
    setState(() {
      _counter++;
      SpUtil.putInt(spLastCounter, _counter);
    });
  }

  @override
  void initState() {
    super.initState();

    /// use sp.
    _counter = SpUtil.getInt(spLastCounter, defValue: 0)!;

    test();
//    /// examples
//    SpUtil.putString("username", "sky24");
//    String? userName = SpUtil.getString("username", defValue: "");
//    LogUtil.e("userName: $userName");
//
//    SpUtil.putString("username1", "sky24 1");
//    String? userName1 = SpUtil.getString("username1", defValue: "");
//    LogUtil.e("userName1: $userName1");

    /// save object example.
    /// 存储实体对象示例。
    City city = City(name: "成都市");
    SpUtil.putObject("loc_city", city);

    City? hisCity = SpUtil.getObj(
        "loc_city", (v) => City.fromJson(v as Map<String, dynamic>));
    LogUtil.e("City: " + (hisCity == null ? "null" : hisCity.toString()));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = [];
    list.add(City(name: "成都市"));
    list.add(City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<City>? dataList = SpUtil.getObjList(
        "loc_city_list", (v) => City.fromJson(v as Map<String, dynamic>));
    LogUtil.e("CityList: " + (dataList == null ? "null" : dataList.toString()));
  }

  void test() async {
    /// examples
    await SpUtil.putString("username", "sky24");
    String? userName = SpUtil.getString("username", defValue: "");
    LogUtil.e("userName: $userName");

    await SpUtil.putString("username1", "sky24 1");
    String? userName1 = SpUtil.getString("username1", defValue: "");
    LogUtil.e("userName1: $userName1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
