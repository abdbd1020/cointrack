import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/controller/example.dart';
import 'package:swe/controller/plannedPaymentController.dart';
import 'package:swe/model/account.dart';
import 'package:swe/model/transaction.dart';
import 'package:swe/pages/accountsPage.dart';
import 'package:swe/pages/statPage.dart';
import '../Misc/colors.dart';
import '../component/card/accountCard.dart';
import '../component/commonUI.dart';
import '../component/drawerUI.dart';
import '../component/buttons/generalActionButton.dart';
import '../controller/statisticsController.dart';
import '../controller/transactionController.dart';
import 'addEditTransactionPage.dart';
import 'historyPage.dart';
import 'loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Account> accounts;
  List<TransactionModel> transactions = [];
  List<TransactionModel> finalTransactions = [];
  Map<String, double> dataMap = {};

  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    accounts = await AccountController.instance.readAllAccounts();
    transactions = await TransactionController.instance.readAllRecords();
    int count = 0;
    int index = 0;
    for(index = 0;index<transactions.length;index++){
      if (transactions[transactions.length - index - 1]
          .category ==
          debtString ||
          transactions[transactions.length - index - 1]
              .time ==
              iniTime) {
        continue;
      }
      else{
        finalTransactions.add(transactions[transactions.length - index - 1]);
        count++;
      }
      if(count==3)break;
    }



    int a = await TransactionController.instance.maxItem();
    dataMap = await StatisticsController.instance.getAllData();

    if (accounts.isEmpty) {
      makeFirstAccount();
    }

    setState(() => isLoading = false);
    await PlannedPaymentController.instance.check();
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
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditTransactionPage(
                          accounts: accounts,
                        )),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Accounts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                        children: List.generate(
                            accounts == null ? 0 : accounts.length, (index) {
                      return Column(
                        children: [
                          Container(

                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(
                                color: Colors.grey, // red as border color
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //   width: (size.width - 40) * 0.7,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 15),
                                      SizedBox(
                                        //width: (size.width - 90) * 0.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              accounts[index].name,
                                              style: const TextStyle(
                                                  fontSize: 15,
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
                                  // width: (size.width - 40) * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        accounts[index].amount.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    })),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AccountsPage(),
                              ),
                            );
                          },
                          child: Container(

                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green, // red as border color
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: const [
                                SizedBox(width: 15),
                                Icon(Icons.settings,color: Colors.green,),
                                SizedBox(width: 5,),
                                Text(
                                  "Manage Accounts",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Transaction History",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                              children: List.generate(
                                  finalTransactions == null
                                      ? 0
                                      :  finalTransactions.length, (index) {
                         

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //   width: (size.width - 40) * 0.7,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: finalTransactions[index]
                                                          .isIncome ==
                                                      1
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            child: const Center(
                                                child: Icon(
                                              Icons.attach_money,
                                              color: Colors.white,
                                            )),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            //width: (size.width - 90) * 0.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  finalTransactions[
                                                          index]
                                                      .category,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  finalTransactions[
                                                          index]
                                                      .time,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  finalTransactions[index]
                                                          .accountName ??
                                                      "Cash",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // width: (size.width - 40) * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            finalTransactions[index]
                                                .amount
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: transactions[transactions
                                                                    .length -
                                                                index -
                                                                1]
                                                            .isIncome ==
                                                        1
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 65, top: 8),
                                  child: Divider(
                                    thickness: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          })),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryPage(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              "Show More",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Statistics",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FutureBuilder<Map<String, double>>(
                        future: StatisticsController.instance.getAllData(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if(dataMap.isEmpty) {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No Data to Show",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  );
                                }
                                else {
                                  return Container(
                                    child: Container(
                                  // width: (size.width - 20),
                                  height: 150,
                                  child: PieChart(dataMap: dataMap),
                                ));
                                }
                              }
                          }
                          return Container();
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatisticsPage(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              "Show More",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Container(child: CustomTextWidget("Accounts", bold: true));
  }

  Future<void> refreshPage() async {
    return;
  }

  Future<void> makeFirstAccount() async {
    var firstAccount =
        Account(id: 0, name: "Cash", amount: 0, type: cashString);
    await AccountController.instance.create(firstAccount);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (Route<dynamic> route) => false,
    );
  }
}
