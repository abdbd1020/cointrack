
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
    print(transactions[0].toString());


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

          'Transaction',
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
    return SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 20,),
          Padding(

            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(

                children: List.generate(transactions.length, (index) {
                  if(transactions[index].category == debtString ||transactions[index].time == iniTime )return Container();

                  return Column(

                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTransactionPage(accounts: accounts,transaction: transactions[index]),
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
                                      color: transactions[index].isIncome==1?Colors.green:Colors.red,
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
                                          transactions[index].category,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          transactions[index].time,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          transactions[index].accountName ?? "Cash",

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
                                    transactions[index].amount.toString(),

                                    style:  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: transactions[index].isIncome==1?Colors.green:Colors.red),
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        color: black.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "\$1780.00",
                    style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


}
