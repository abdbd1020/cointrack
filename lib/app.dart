import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/pages/homePage.dart';
import 'package:swe/pages/loginPage.dart';
import 'package:swe/controller/accountController.dart';


class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {
  bool isPass = false;
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>(debugLabel: "navigator");

  @override
  void initState() {
    super.initState();
    initProject();

  }

  void initProject() async {
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getBool('isPass')==null){
      await prefs.setBool('isPass', false);
    }
    isPass = prefs.getBool('isPass');
    WidgetsFlutterBinding.ensureInitialized();

  }


  @override
  Widget build(BuildContext context) {
    // start app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isPass ?LoginPage(): HomePage() ,
    );
  }


}
