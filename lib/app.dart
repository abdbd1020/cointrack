import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe/router.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>(debugLabel: "navigator");

  @override
  void initState() {
    super.initState();
    initProject();
  }

  void initProject() async {

  }

  @override
  Widget build(BuildContext context) {
    // start app
    return MaterialApp(
      title: 'Cointrack',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),


      onGenerateRoute: buildRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
