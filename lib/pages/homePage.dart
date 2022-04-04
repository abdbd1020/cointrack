import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/modal/account.dart';

import '../component/card/accountCard.dart';
import '../component/commonUI.dart';
import '../component/drawerUI.dart';
import '../component/generalActionButton.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [
    Student(name: "Bkash", rollno: 160),
    Student(name: "DBBL", rollno: 0.0),
    Student(name: "MTB", rollno: 3600),
    Student(name: "Rocket", rollno: 5644)
  ];


  int a = 0;
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
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Card(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 280,
                  child: Material(
                    shadowColor: Colors.grey[100]?.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    elevation: 3,
                    clipBehavior: Clip.antiAlias, // Add This
                    child:Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 5, bottom: 0, right: 5, top: 0),
                      child:  ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: students.length,
                        itemBuilder: (context, int index) {
                          return index >= students.length
                              ? Container()
                              : AccountCard(name: students[index].name, amount : students[index].rollno);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 50,
                  child: Material(
                    shadowColor: Colors.grey[100]?.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    elevation: 3,
                    clipBehavior: Clip.antiAlias, // Add This
                    child:
                    Container (
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 50, bottom: 0, right: 50, top: 0),
                        child:  buildViewDetailsButton(context)
                    )
                  )
                )
              ],
            ),
          ),
        ));
  }

  Widget buildAccountCard() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10),
          buildTitle(),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
            //child: buildList(),
          ),
          SizedBox(height: 5),
          buildViewDetailsButton(context),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Container(child: CustomTextWidget("Accounts", bold: true));
  }

  Widget buildViewDetailsButton(BuildContext context) {
    return GeneralActionButton(
      title: 'Manage Accounts',
      height: 40,
      textFontSize: 17,
      textColor: Colors.white,
      showNextIcon: false,
      color: Colors.red,
      padding: EdgeInsets.all(0),
      callBackOnSubmit: doChange,
    );
  }

  Future<void> refreshPage() async {
    return;
  }

  Future<void> doChange() async {
    if (a == 0) {
      a = 1;
      var fido = const Account(
        id: 0,
        name: 'Fido',
        amount: 35,
        type: "cash",
      );

      await AccountController().insertDog(fido);
    } else {
      a = 0;
      String m = await AccountController().dogs().toString();
      Fluttertoast.showToast(
          msg: m,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
class Student{
  String name;
  double rollno;

  Student({ this.name,  this.rollno});
}

