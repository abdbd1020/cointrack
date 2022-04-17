
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';
import '../Misc/colors.dart';
import '../component/drawerUI.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import 'addEditTransactionPage.dart';



class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  bool isLoading = false;
  List<Account> accounts;
  List<TransactionModel> transactions = [];


  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    transactions = await TransactionController.instance.readAllRecords();
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

          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),

      body: getBody(),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0,0,10,20),
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddEditTransactionPage(accounts: accounts)),
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
    return transactions.isEmpty?Container(
      alignment: Alignment.center,
      child: const Text("NO Data to Show",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ): SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 20,),
          Padding(

            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(

                children: List.generate(transactions.length, (index) {
                  if(transactions[transactions.length-index-1].category == debtString ||transactions[transactions.length-index-1].time == iniTime )return Container();

                  return Column(

                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTransactionPage(accounts: accounts,transaction: transactions[transactions.length-index-1]),
                            ),
                          );
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
                                      color: transactions[transactions.length-index-1].isIncome==1?Colors.green:Colors.red,
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
                                          transactions[transactions.length-index-1].category,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          transactions[transactions.length-index-1].time,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          transactions[transactions.length-index-1].accountName ?? "Cash",

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
                                    transactions[transactions.length-index-1].amount.toString(),

                                    style:  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: transactions[transactions.length-index-1].isIncome==1?Colors.green:Colors.red),
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


}
