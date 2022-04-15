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

class StatisticsController {

  static final StatisticsController instance = StatisticsController._init();
  static bool isChecked = false;


  StatisticsController._init();

  Future <Map<String,double>> getIncomeData() async {
    Map<String,double>dataMap={};
    List<TransactionModel> transactionModels;
    transactionModels = await TransactionController.instance.readAllRecords();

    int count = 0;
    for(TransactionModel transactionModel in transactionModels){
      if(count==30)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString)continue;
      if(dataMap[transactionModel.category]==null) {
        dataMap.putIfAbsent(transactionModel.category, () => transactionModel.amount);
      }
      else
      {
        dataMap.update(transactionModel.category, (value) => value + transactionModel.amount);
      }


    }
    return dataMap;


      }

  }









