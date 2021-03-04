import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

/// Example Two.
/// add SplashPage, complete sp initialization on the SplashPage. Then you can use it synchronously to the homepage。
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
    ///  await sp initialization to complete.
    await SpUtil.getInstance();
    String userName = SpUtil.getString("username");
    print('userName: $userName');
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
  TimerUtil _timerUtil;
  int _count = 3;
  int _type = 0;

  @override
  void initState() {
    super.initState();
    _timerUtil = TimerUtil(mTotalTime: 3000);
    _timerUtil.setOnTimerTickCallback((ms) {
      _count = ms ~/ 1000;
      setState(() {});
      if (_count == 0) {
        _goMain();
      }
    });
    _initAsync();
  }

  void _initAsync() async {
    Future.delayed(Duration(milliseconds: 500), () async {
      /// await SpUtil initialization to complete.
      await SpUtil.getInstance();

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

  /// show add guide
  /// App引导页逻辑。
  void _initBanner() {
    _type = 1;
    setState(() {});

    ///
  }

  /// show ad.
  /// App广告页逻辑。
  void _initSplash() {
    _type = 2;
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }

  @override
  void dispose() {
    _timerUtil?.cancel();
    super.dispose();
  }

  String getInfo() {
    String info = '';
    switch (_type) {
      case 1:
        info = 'Guide Page';
        break;
      case 2:
        info = 'Ad $_count';
        break;
    }
    LogUtil.e("getInfo info: $info");
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: Center(
        child: Text(getInfo()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goMain();
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

    /// use sp.
    String userName = SpUtil.getString("username");
    print('userName: $userName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child:
            Text('UserName: ${SpUtil.getString("username", defValue: null)}'),
      ),
    );
  }
}
