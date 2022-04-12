import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/model/account.dart';
import 'package:swe/pages/accountsPage.dart';
import 'package:swe/pages/statPage.dart';

import '../component/card/accountCard.dart';
import '../component/commonUI.dart';
import '../component/drawerUI.dart';
import '../component/buttons/generalActionButton.dart';
import 'addEditTransactionPage.dart';
import 'historyPage.dart';
import 'lendBorrowPage.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Account> accounts;


  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.accounts = await AccountController.instance.readAllAccounts();


    setState(() => isLoading = false);
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
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddEditTransactionPage(accounts: accounts,)),
            );
          },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,),
        ),


      ),
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

                        child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.only(left: 5, bottom: 0, right: 5, top: 0),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : accounts==null
                                ? const Text(
                                    'No database',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24),
                                  )
                        : accounts.isEmpty?const Text(
                          'No Accounts',
                          style: TextStyle(
                              color: Colors.black, fontSize: 24),
                        )

                          : ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: accounts.length,
                                    itemBuilder: (context, int index) {
                                      return index >= accounts.length
                                          ? Container()
                                          : AccountCard(
                                              name: accounts[index].name,
                                              amount: accounts[index].amount.toDouble());
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
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 50, bottom: 0, right: 50, top: 0),
                            child: buildViewDetailsButton(context)))),
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
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 50, bottom: 0, right: 50, top: 0),
                            child: buildViewHistoryButton(context))))
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
      isProcessing: false,
      padding: EdgeInsets.all(0),
      callBackOnSubmit: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountsPage()),
        );
      },
    );
  }
  Widget buildViewHistoryButton(BuildContext context) {
    return GeneralActionButton(
      title: 'View History',
      height: 40,
      textFontSize: 17,
      textColor: Colors.white,
      showNextIcon: false,
      color: Colors.red,
      isProcessing: false,
      padding: EdgeInsets.all(0),
      callBackOnSubmit: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
      },
    );
  }

  Future<void> refreshPage() async {
    return;
  }


}


