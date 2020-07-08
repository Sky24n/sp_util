import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

import 'example2.dart';
import 'models.dart';

/// Example One.
/// await SpUtil initialization to complete before running the app.
/// sp init time release about 30ms，debug about 100ms.(Test on Android.)
//  int old = DateTime.now().millisecondsSinceEpoch;
//  await SpUtil.getInstance();
//  int now = DateTime.now().millisecondsSinceEpoch;
//  print('sp init time: ${now - old}');
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
  MyHomePage({Key key, this.title}) : super(key: key);

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
    _counter = SpUtil.getInt(spLastCounter, defValue: 0);

    /// examples
    SpUtil.putString("username", "sky24");
    String userName = SpUtil.getString("username", defValue: "");
    print("thll userName: " + userName);

    /// save object example.
    /// 存储实体对象示例。
    City city = City();
    city.name = "成都市";
    SpUtil.putObject("loc_city", city);

    City hisCity = SpUtil.getObj("loc_city", (v) => City.fromJson(v));
    print("thll City: " + (hisCity == null ? "null" : hisCity.toString()));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = List();
    list.add(City(name: "成都市"));
    list.add(City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<City> dataList =
        SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
    print(
        "thll CityList: " + (dataList == null ? "null" : dataList.toString()));
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
