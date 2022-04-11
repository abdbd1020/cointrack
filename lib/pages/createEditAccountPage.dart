
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../Misc/categories.dart';
import '../Misc/colors.dart';
import '../component/appBarBackButton.dart';
import '../model/account.dart';

class CreateEditAccountPage extends StatefulWidget {

  const CreateEditAccountPage({Key key, this.account}) : super(key: key);
  final Account account;

  @override
  _CreateEditAccountPage createState() => _CreateEditAccountPage(account);
}

class _CreateEditAccountPage extends State<CreateEditAccountPage> {
  Account account;
  _CreateEditAccountPage(this.account);
  int activeCategory = 0;
  TextEditingController _budgetName =
  TextEditingController(text: "Grocery Budget");
  TextEditingController _budgetPrice = TextEditingController(text: "\$1500.00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        elevation: 1,
        centerTitle: true,
        title: account==null? Text(
          'Add Account',
          style: TextStyle(color: Colors.white),
        ):
        Text(
          'Edit Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),

          ),



          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: _budgetName,
                  cursorColor: black,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
                  decoration: account==null?  InputDecoration(
                     hintText: "Enter Account Name", border: InputBorder.none)
                :
            InputDecoration(
                hintText: account.name, border: InputBorder.none),
          ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            controller: _budgetPrice,
                            cursorColor: black,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold, color: black),
                            decoration: account==null?  InputDecoration(
                                hintText: "Enter Initial Amount", border: InputBorder.none)
                                :
                            InputDecoration(
                                hintText: account.amount.toString(), border: InputBorder.none),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
