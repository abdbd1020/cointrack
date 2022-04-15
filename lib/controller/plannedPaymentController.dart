import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/controller/timerController.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';

import '../model/account.dart';
import '../model/debt.dart';
import '../model/plannedPaymentModel.dart';

class PlannedPaymentController {
  DateTime now = DateTime.now();
  DateFormat monthFormatter = DateFormat('MM');
  DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
  DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
  DateFormat dayFormatter = DateFormat('dd');
  String formattedMonth;
  String formattedDay ;
  String formattedTime;
  String formattedDate;

  static final PlannedPaymentController instance = PlannedPaymentController._init();
  static bool isChecked = false;


  PlannedPaymentController._init();

  Future check() async {
    formattedMonth = monthFormatter.format(now);
    formattedDay = dayFormatter.format(now);
    formattedTime = formatter.format(now);
    formattedDate = dateFormatter.format(now);


    List<PlannedPayment> plannedPayments =  await TimerController.instance.readAllRecords();
    for(PlannedPayment plannedPayment in plannedPayments){
      if(plannedPayment.recurrence==monthlyString){
        final splitArr = plannedPayment.lastDate.split('-');
        if(splitArr[1]!=formattedMonth){
          doTransaction(plannedPayment);


        }
      }
      else if(plannedPayment.recurrence==dailyString){
        final splitArr = plannedPayment.lastDate.split('-');
        if(splitArr[1]!=formattedMonth||splitArr[0]!=formattedDay){
          doTransaction(plannedPayment);

        }
      }
      else if(plannedPayment.recurrence==weeklyString){
        if((plannedPayment.lastDate!=iniTime&&plannedPayment.lastDate != formattedDate)||plannedPayment.lastDate==iniTime){

            if(DateFormat('EEEE').format(DateTime.now())==DateFormat('EEEE').format(DateFormat("dd-MM-yyyy").parse(plannedPayment.date))){
              doTransaction(plannedPayment);

          }

        }



      }
    }
  }

  Future doTransaction(PlannedPayment plannedPayment) async {

    TransactionModel transaction = await TransactionController.instance.getSingleAccount(plannedPayment.transactionId);
    transaction.time = formattedTime;
    transaction.id = await TransactionController.instance.maxItem()+1;
    await TransactionController.instance.create(transaction);
    if(transaction.isIncome==0)transaction.amount*=-1;
    Account account = await AccountController.instance.getSingleAccount(transaction.accountId);
    account.amount+=transaction.amount;
    await AccountController.instance.update(account);
    plannedPayment.lastDate = formattedDate;
    await TimerController.instance.update(plannedPayment);
  }




}


