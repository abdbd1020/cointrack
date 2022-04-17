import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swe/controller/debtController.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';
import 'package:swe/pages/historyPage.dart';

import '../Misc/Strings.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';
import '../controller/accountController.dart';
import '../model/account.dart';
import '../model/debt.dart';
import 'homePage.dart';


class AddEditDebtPage extends StatefulWidget {
  const AddEditDebtPage({Key key, this.transaction, this.accounts, this.debt,}) : super(key: key);
  final TransactionModel transaction;
  final Debt debt;

  final List<Account> accounts;

  @override
  _AddEditDebtPage createState() => _AddEditDebtPage(transaction,accounts,debt);
}

class _AddEditDebtPage extends State<AddEditDebtPage> {
  TransactionModel transaction;
  List<Account> accounts;

  bool isLoading;

  Debt debt;
  _AddEditDebtPage(this.transaction,this.accounts, this.debt);
  String dropdownValue;
  String dropdownTypeValue;
  String dropdownCategoryValue;
  Account selectedAccount;
  double initialAmount;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dueTimeController = TextEditingController();
  TextEditingController debtNameController = TextEditingController();

  TextEditingController accountAmountController = TextEditingController();
  int transactionId=0;
  int debtId=0;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDueDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    descriptionController.text = "";
    accountAmountController.text = accountAmount();
    debtNameController.text = debtName();
    dropdownTypeValue = debt==null? lendString:debt.isLend==0?borrowString:lendString;
    selectedAccount =transaction==null? accounts[0]:getAccount(accounts,transaction.accountId);
    initialAmount = transaction==null? 0:transaction.amount;
    timeController.text =
    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    dueTimeController.text =
    "${selectedDueDate.day}/${selectedDueDate.month}/${selectedDueDate.year}";





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
          'Add Transaction',
          style: TextStyle(color: Colors.white),
        )
            : const Text(
          'Edit Transaction',
          style: TextStyle(color: Colors.white),
        ),
        actions: [transaction!=null?AppBarDeleteButton():TextButton(
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

        margin: const EdgeInsets.fromLTRB(0,0,10,20),
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: addEditDebt,
            child: const Icon( Icons.arrow_forward,
              color: white,),
            backgroundColor: Colors.green,),
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
                  "Debt type",
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
                  items: <String>[lendString,borrowString]
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
                        fontWeight: FontWeight.bold),
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    TextField(
                      controller: debtNameController,
                      cursorColor: black,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: black),
                      decoration: const InputDecoration(
                          hintText: "Enter lender/borrower Name",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.yellow
                              ))),
                    ),

                  ],
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
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Due Date",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                InkWell(
                  onTap: () {
                    _selectDueDate(context);
                  },
                  child: TextField(
                    controller: dueTimeController,
                    enabled: false,
                    readOnly: true,
                    cursorColor: black,
                    style: const TextStyle(
                        fontSize: 17,

                        color: black),
                    decoration: const InputDecoration(
                        hintText: "Select Date",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
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
                  items: accounts?.map<DropdownMenuItem<Account>>((Account account) {
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
                      fontWeight: FontWeight.bold),
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
                          hintText: "Enter Amount",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black
                              ))),
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
                      controller: descriptionController,
                      cursorColor: black,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: black),
                      decoration: const InputDecoration(
                          hintText: "Add description",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.yellow
                              ))),
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
  String debtName() {
    if (debt == null) {
      return "";
    } else {
      return debt.name;
    }
  }


  Future addEditDebt() async {
    if (accountAmountController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Amount is needed"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }  if (debtNameController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Name is needed"),
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

    if (debt != null) {
      transactionId = transaction.id;
      debtId = debt.id;
    } else {
      int temp =  await DebtController.instance.maxItem();
      debtId = temp==null?0:temp+1;
      int temp1 = await TransactionController.instance.maxItem();
      transactionId = temp1==null?0:temp1+1;
    }

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('HH:mm');
    String tempTime = formatter.format(now);
    String formattedTime = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}" +"  "+ tempTime;
    String formattedDueTime = "${selectedDueDate.day}-${selectedDueDate.month}-${selectedDueDate.year}";

    int isIncomeInt = 0;
    if (dropdownTypeValue == borrowString) {
      isIncomeInt = 1;
    }
    bool isUpdate = true;
    if (transaction == null) isUpdate = false;

    transaction = TransactionModel(
        id: transactionId,
        accountName: selectedAccount.name,
        accountId: selectedAccount.id,
        category: debtString,
        isIncome: isIncomeInt,
        description: descriptionController.text,
        amount: double.parse(accountAmountController.text),
        time: formattedTime);
    debt = Debt(
        id: debtId,
        transactionId: transactionId,
        name: debtNameController.text,
        amount: double.parse(accountAmountController.text),
        isLend: isIncomeInt,
        dueDate: formattedDueTime,
      );
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
      await DebtController.instance.update(debt);
      await TransactionController.instance.update(transaction);
    } else {
      await DebtController.instance.create(debt);
      await TransactionController.instance.create(transaction);
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successful"),
      duration: Duration(milliseconds: 500),
    ));
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
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
          await DebtController.instance.delete(debt.id);
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
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
    timeController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
  }
  _selectDueDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDueDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDueDate)
      setState(() {
        selectedDueDate = selected;
      });
    dueTimeController.text = "${selectedDueDate.day}-${selectedDueDate.month}-${selectedDueDate.year}";
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }



}
