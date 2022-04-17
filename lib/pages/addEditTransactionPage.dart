import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';
import 'package:swe/pages/historyPage.dart';

import '../Misc/Strings.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import 'accountsPage.dart';
import 'homePage.dart';

class AddEditTransactionPage extends StatefulWidget {
  const AddEditTransactionPage({Key key, this.transaction, this.accounts})
      : super(key: key);
  final TransactionModel transaction;
  final List<Account> accounts;

  @override
  _AddEditTransactionPage createState() =>
      _AddEditTransactionPage(transaction, accounts);
}

class _AddEditTransactionPage extends State<AddEditTransactionPage> {
  TransactionModel transaction;
  List<Account> accounts;

  bool isLoading;
  _AddEditTransactionPage(this.transaction, this.accounts);
  String dropdownValue;
  String dropdownTypeValue;
  String dropdownCategoryValue;
  Account selectedAccount;
  double initialAmount;
  String date = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController descriptionConroller = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TextEditingController accountAmountController = TextEditingController();
  int transactionId = 0;

  @override
  void initState() {
    super.initState();
    descriptionConroller.text = "";
    accountAmountController.text = accountAmount();
    dropdownTypeValue = transaction == null
        ? expenseString
        : transaction.isIncome == 0
            ? expenseString
            : incomeString;
    dropdownCategoryValue =
        transaction == null ? foodAndDrinksString : transaction.category;
    selectedAccount = transaction == null
        ? accounts[0]
        : getAccount(accounts, transaction.accountId);
    initialAmount = transaction == null ? 0 : transaction.amount;
    timeController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    // dropdownValue = account == null ? cashString : account.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        elevation: 1,
        centerTitle: true,
        title: transaction == null
            ? const Text(
                'Add transaction',
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                'Edit transaction',
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          transaction != null
              ? AppBarDeleteButton()
              : TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Text(''),
                )
        ],
      ),
      backgroundColor: white.withOpacity(0.95),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: addEditTransaction,
            child: const Icon(
              Icons.arrow_forward,
              color: white,
            ),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // var size = MediaQuery.of(context).size;
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Transaction type",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                DropdownButton<String>(
                  focusColor: Colors.white,
                  value: dropdownTypeValue,
                  isExpanded: true,

                  // elevation: 5,
                  iconEnabledColor: Colors.black,
                  items: <String>[expenseString, incomeString]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
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
                      dropdownTypeValue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Transaction account",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                DropdownButton<Account>(
                  focusColor: Colors.white,
                  value: selectedAccount,
                  isExpanded: true,

                  // elevation: 5,
                  iconEnabledColor: Colors.black,
                  items: accounts
                      ?.map<DropdownMenuItem<Account>>((Account account) {
                    return DropdownMenuItem<Account>(
                      value: account,
                      child: Text(account.name),
                    );
                  })?.toList(),
                  hint: const Text(
                    "Please choose an account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (Account account) {
                    setState(() {
                      selectedAccount = account;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  focusColor: Colors.white,
                  value: dropdownCategoryValue,
                  isExpanded: true,

                  // elevation: 5,
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    foodAndDrinksString,
                    shoppingString,
                    housingString,
                    transportationString,
                    groceriesString,
                    othersString,
                    incomeString,
                    tuitionString,
                    investmentString
                  ].map<DropdownMenuItem<String>>((String value) {
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
                      dropdownCategoryValue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      cursorColor: black,
                      style: const TextStyle(
                          fontSize: 17,
                          
                          color: black),
                      decoration: const InputDecoration(
                          hintText: "Enter Amount",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: TextField(
                        controller: timeController,
                        enabled: false,
                        readOnly: true,
                        cursorColor: black,
                        style: const TextStyle(
                            fontSize: 17,
                            
                            color: black),
                        decoration: const InputDecoration(
                            hintText: "Select Date",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    TextField(
                      controller: descriptionConroller,
                      cursorColor: black,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 17,
                          
                          color: black),
                      decoration: const InputDecoration(
                          hintText: "Add description",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow))),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String accountAmount() {
    if (transaction == null) {
      return "";
    } else {
      return transaction.amount.toString();
    }
  }

  Future addEditTransaction() async {
    if (accountAmountController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Amount is needed"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }
    if (!isNumeric(accountAmountController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid amount"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }
    if (transaction != null) {
      transactionId = transaction.id;
    } else {
      List<TransactionModel> transaction =
          await TransactionController.instance.readAllRecords();
      int ans = -1;
      for (var acc in transaction) {
        if (ans < acc.id) {
          ans = acc.id;
        }
      }
      ans++;
      transactionId = ans;
    }

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('HH:mm');
    String formattedTime = formatter.format(now);
    formattedTime = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}" + formattedTime;

    int isIncomeInt = 0;
    if (dropdownTypeValue == incomeString) {
      isIncomeInt = 1;
    }
    bool isUpdate = true;
    if (transaction == null) isUpdate = false;

    transaction = TransactionModel(
        id: transactionId,
        accountName: selectedAccount.name,
        accountId: selectedAccount.id,
        category: dropdownCategoryValue,
        isIncome: isIncomeInt,
        description: descriptionConroller.text,
        amount: double.parse(accountAmountController.text),
        time: formattedTime);
    double iniAmount =
        (double.parse(accountAmountController.text) - initialAmount);
    if (isIncomeInt == 1) {
      iniAmount = iniAmount * -1;
    }
    Account currentAccount =
        await AccountController.instance.getSingleAccount(selectedAccount.id);
    double finalAmount = currentAccount.amount - iniAmount;
    var updatedAccount = Account(
        id: selectedAccount.id,
        name: selectedAccount.name,
        amount: finalAmount,
        type: currentAccount.type);
    await AccountController.instance.update(updatedAccount);

    if (isUpdate) {
      await TransactionController.instance.update(transaction);
    } else {
      await TransactionController.instance.create(transaction);
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successful"),
      duration: Duration(milliseconds: 500),
    ));
    await Future.delayed(const Duration(seconds: 1), (){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
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
          await TransactionController.instance.delete(transaction.id);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage()),
          );
        });
  }

  getAccount(List<Account> accounts, int accountId) {
    for (var acc in accounts) {
      if (acc.id == accountId) return acc;
    }
    return accounts[0];
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(

      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    timeController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

}
