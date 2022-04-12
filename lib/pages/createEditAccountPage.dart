import 'package:flutter/material.dart';

import '../Misc/Strings.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import 'accountsPage.dart';


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
  String dropdownValue;
  TextEditingController accountNameController = TextEditingController();

  TextEditingController accountAmountController = TextEditingController();
  int accountId=0;

  @override
  void initState() {
    super.initState();
    accountNameController.text = accountName();
    accountAmountController.text = accountAmount();
    dropdownValue = account == null ? cashString : account.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        elevation: 1,
        centerTitle: true,
        title: account == null
            ? const Text(
                'Add Account',
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                'Edit Account',
                style: TextStyle(color: Colors.white),
              ),
        actions: [account!=null?AppBarDeleteButton():TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          onPressed: () { },
          child: Text(''),
        )],
      ),

      backgroundColor: white.withOpacity(0.95),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15)),

        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: addEditAccount,
            child: Icon( Icons.arrow_forward,
              color: white,),
            backgroundColor: Colors.red,),
        ),


      ),
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
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Account Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                    controller: accountNameController,
                    cursorColor: black,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: black),
                    decoration: const InputDecoration(
                        hintText: "Enter Account Name",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.yellow
                            ))),
                ),

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Account type",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                DropdownButton<String>(
                  focusColor: Colors.white,
                  value: dropdownValue,
                  isExpanded: true,

                  // elevation: 5,
                  iconEnabledColor: Colors.black,
                  items: <String>[cashString, bankString, mobileBankString]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: const Text(
                    "Please choose a type",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Amount",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        TextField(
                            controller: accountAmountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),

                          cursorColor: black,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: black),
                            decoration: const InputDecoration(
                                hintText: "Enter Initial Amount",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black
                                    ))),
                        )

                      ],
                    ),


              ],
            ),
          )
        ],
      ),
    );
  }

  String accountName() {
    if (account == null) {
      return "";
    } else {
      return account.name;
    }
  }

  String accountAmount() {
    if (account == null) {
      return "";
    } else {
      return account.amount.toString();
    }
  }

  Future addEditAccount() async {
    if(accountNameController.text==""){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Account Name is needed"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }
    if(accountAmountController.text==""){

      accountAmountController.text=="0";
    }
    if(account!=null){
      accountId = account.id;
    }
    else{
      List<Account> accounts = await AccountController.instance.readAllAccounts();
      int ans = -1;
      for (var acc in accounts) {
        if(ans<acc.id){
          ans = acc.id;
        }
      }
      ans++;
      accountId = ans;
    }
    bool isUpdate = true;
    if(account==null)isUpdate = false;
      account =  Account(
        id: accountId,
        name: accountNameController.text,
        amount:double.parse(accountAmountController.text) ,
        type: dropdownValue,
      );
      if(isUpdate){
        await AccountController.instance.update(account);
      }
      else{
        await AccountController.instance.create(account);
      }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successful"),
      duration: Duration(milliseconds: 500),
    ));
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountsPage()),
    );

  }

  AppBarDeleteButton() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 25,
      ),
      onPressed: () async {
        await AccountController.instance.delete(account.id);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountsPage()),
        );
      }
    );
  }
}
