

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/debtController.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';
import 'package:swe/pages/addEditDebtPage.dart';

import '../Misc/colors.dart';
import '../component/drawerUI.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import '../model/debt.dart';
import 'addEditTransactionPage.dart';
import 'createEditAccountPage.dart';


class DebtsPage extends StatefulWidget {
  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {

  bool isLoading = false;
  List<Account> accounts;
  List<Debt> debt = [];
  String lendOrBorrowString = "Lend";

  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    debt = await DebtController.instance.readAllRecords();
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

          'Debts',
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
              MaterialPageRoute(builder: (context) =>  AddEditDebtPage(accounts: accounts)),
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
    return debt.isEmpty?Container(
      alignment: Alignment.center,
      child: const Text("NO Data to Show",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ): SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 20,),
          Padding(

            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(

                children: List.generate(debt.length, (index) {

                  return Column(

                    children: [
                      InkWell(
                        onTap:(){ changeToAddDebtPage(debt[debt.length-index-1].transactionId,debt[debt.length-index-1].id);
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
                                      color: debt[debt.length-index-1].isLend==1?Colors.green:Colors.red,
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
                                          debt[debt.length-index-1].isLend==0?"Me -> "+ debt[debt.length-index-1].name:debt[debt.length-index-1].name+" -> Me",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2,),
                                        Text(
                                          "Due date -> "+ debt[debt.length-index-1].dueDate ,

                                          style: const TextStyle(
                                              fontSize: 13,
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
                                    debt[debt.length-index-1].amount.toString(),

                                    style:  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: debt[debt.length-index-1].isLend==1?Colors.green:Colors.red),
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

  changeToAddDebtPage(int transactionId,int debtId) async {
    TransactionModel transaction = await TransactionController.instance.getSingleAccount(transactionId);
    Debt debt = await DebtController.instance.getSingleAccount(debtId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditDebtPage(accounts: accounts,transaction: transaction,debt: debt)
      ),
    );
  }


}
