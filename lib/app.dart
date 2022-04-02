import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swe/pages/homePage.dart';
import 'package:swe/pages/loginPage.dart';
import 'package:swe/router.dart';


class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {
  bool isLogin = true;
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>(debugLabel: "navigator");

  @override
  void initState() {
    super.initState();
    initProject();
  }

  void initProject() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    isLogin = prefs.getBool('isLogin')!;
  }


  @override
  Widget build(BuildContext context) {
    // start app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? HomePage() : LoginPage(),
    );
  }


}
