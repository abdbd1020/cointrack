import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';

import 'package:swe/controller/statisticsController.dart';
import 'package:swe/model/transaction.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';



class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool isAllowPass;
  bool isLoading;
  List<TransactionModel> transactionModels;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  Map<String, double> dataMap = {
  };
  Map<String, double> expenseDataMap = {
  };
  Map<String, double> allDataMap = {
  };
  double totalIncome = 0;
  double totalExpense = 0;

  Future refreshNotes() async {
    setState(() => isLoading = true);

    dataMap = await StatisticsController.instance.getIncomeData();
    expenseDataMap = await StatisticsController.instance.getExpenseData();
    totalIncome = await StatisticsController.instance.getTotalIncome();
    totalExpense = await StatisticsController.instance.getTotalExpense();
    allDataMap = await StatisticsController.instance.getAllData();






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
      appBar: AppBar(
        leading: AppBarBackButton(),
        elevation: 1,
        centerTitle: true,
        title:  const Text(

          'Statistics',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),

      body: getBody(),


    );
  }



  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": "Income",
        "cost": "$totalIncome"
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": "Expense",
        "cost": "$totalExpense"
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 60,
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
                        children: const [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Statistics of Last 100 transaction",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
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
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: FutureBuilder<double>(
                      future: StatisticsController.instance.getTotalIncome(),
                      builder: (context,snapshot) {
                        switch (snapshot.connectionState) {

                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            else{
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: expenses[index]['color']),
                                    child: Center(
                                        child: Icon(
                                          expenses[index]['icon'],
                                          color: white,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expenses[index]['label'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xff67727d)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        expenses[index]['cost'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }


                        }
                        return Container();


                      }
                    ),
                  ),
                );
              })),
          const SizedBox(
            height: 20,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                    FutureBuilder<Map<String,double>>(
                      future: StatisticsController.instance.getIncomeData(),
                      builder: ( context,snapshot) {
                        switch (snapshot.connectionState) {

                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            else{
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
                              } else {
                                return Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: (size.width - 20),
                                    height: 150,
                                    child: PieChart(dataMap:dataMap),
                                  ));
                              }
                            }


                        }
                        return Container();
                      },
                    )

                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                    FutureBuilder<Map<String,double>>(
                      future: StatisticsController.instance.getExpenseData(),
                      builder: ( context,snapshot) {
                        switch (snapshot.connectionState) {

                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            else{
                              if(expenseDataMap.isEmpty) {
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

                                return Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: (size.width - 20),
                                    height: 150,
                                    child: PieChart(dataMap:expenseDataMap),
                                  ));
                              }
                            }

                        }
                        return Container();
                      },

                    )


                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "ALl Transaction",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                    FutureBuilder<Map<String,double>>(
                      future: StatisticsController.instance.getAllData(),
                      builder: ( context,snapshot) {
                        switch (snapshot.connectionState) {

                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            else{
                              if(allDataMap.isEmpty) {
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
                                return Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: (size.width - 20),
                                    height: 150,
                                    child: PieChart(dataMap:allDataMap),
                                  ));
                              }
                            }


                        }
                        return Container();
                      },
                    )

                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }


}
