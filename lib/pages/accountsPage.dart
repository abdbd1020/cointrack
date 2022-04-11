

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../Misc/colors.dart';
import '../component/drawerUI.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import '../model/daily.dart';
import '../model/dayMonth.dart';
import 'createEditAccountPage.dart';


class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {

  bool isLoading = false;
  List<Account> accounts;


  int a = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    accounts = await AccountController.instance.readAllAccounts();


    // Account b = await AccountController.instance.create(fido);



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
        title:  Text(

          'Accounts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),

      body: getBody(),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateEditAccountPage()),
            );
          },
            child: Icon(Icons.add),
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

          SizedBox(height: 20,),
          Container(

            child: Padding(

              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(

                  children: List.generate(accounts.length, (index) {
                    return Column(

                      children: [
                        InkWell(
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => CreateEditAccountPage(account: accounts[index]),
                               ),
                             );
                           },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(


                                width: (size.width - 40) * 0.7,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: grey.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/bank.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      width: (size.width - 90) * 0.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            accounts[index].name,
                                            style: TextStyle(
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
                              Container(
                                width: (size.width - 40) * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      accounts[index].amount.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 65, top: 8),
                          child: const Divider(
                            thickness: 0.8,
                          ),

                        ),
                        const SizedBox(height:10),

                      ],

                    );
                  })),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Spacer(),
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
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
