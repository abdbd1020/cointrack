

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/timerController.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/plannedPaymentModel.dart';
import 'package:swe/model/transaction.dart';
import 'package:swe/pages/addEditPlannedPaymentPage.dart';

import '../Misc/colors.dart';
import '../component/drawerUI.dart';
import '../controller/accountController.dart';
import '../model/account.dart';


class PlannedPaymentPage extends StatefulWidget {
  const PlannedPaymentPage({Key key}) : super(key: key);

  @override
  _PlannedPaymentPageState createState() => _PlannedPaymentPageState();
}

class _PlannedPaymentPageState extends State<PlannedPaymentPage> {

  bool isLoading = false;
  List<Account> accounts;
  List<PlannedPayment> plannedPayments = [];


  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    plannedPayments = await TimerController.instance.readAllRecords();
    accounts = await AccountController.instance.readAllAccounts();


    setState(() => isLoading = false);
  }


  @override
  void dispose() {
    super.dispose();
  }

  void refreshUI() {
    if (mounted) {
      setState(() {
        _scaffoldKey = GlobalKey<ScaffoldState>();
      });
    }
  }
  int activeDay = 3;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title:  const Text(

          'Planned Payment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),

      body: getBody(),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddEditPlannedPaymentPage(accounts: accounts)),
            );
          },
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,),
        ),


      ),

    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return plannedPayments.isEmpty?Container(
      alignment: Alignment.center,
      child: const Text("NO Data to Show",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ): SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 20,),
          Padding(

            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(

                children: List.generate(plannedPayments.length, (index) {

                  return Column(

                    children: [
                      InkWell(
                        onTap: () {
                          changePage(plannedPayments[plannedPayments.length-index-1]);
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(


                              width: (size.width - 40) * 0.7,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                        child: Icon(Icons.attach_money,color: Colors.white ,)
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  SizedBox(
                                    width: (size.width - 90) * 0.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plannedPayments[plannedPayments.length-index-1].recurrence,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Last Date: " +(plannedPayments[plannedPayments.length-index-1].lastDate==iniTime?" ": plannedPayments[plannedPayments.length-index-1].lastDate ),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),



                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: (size.width - 40) * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    plannedPayments[plannedPayments.length-index-1].amount.toString(),

                                    style:  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 65, top: 8),
                        child: Divider(
                          thickness: 0.8,
                        ),

                      ),
                      const SizedBox(height:10),

                    ],

                  );
                })),
          ),
          const SizedBox(
            height: 15,
          ),

        ],
      ),
    );
  }

  void changePage(PlannedPayment plannedPayment) async {
    TransactionModel t = await TransactionController.instance.getSingleAccount(plannedPayment.transactionId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditPlannedPaymentPage(accounts: accounts,transaction: t,plannedPayment: plannedPayment),
      ),
    );



  }


}
