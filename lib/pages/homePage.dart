import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  void refreshUI() {
    if (mounted) {
      setState(() {
        _scaffoldKey = new GlobalKey<ScaffoldState>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: refreshPage,
      color: Colors.white,
      backgroundColor: Colors.black,
      child: Text("SDs"),
    );
  }


  Future<void> refreshPage() async {

    return;
  }
}
