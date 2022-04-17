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






  StatisticsController._init();

  setRecords() async {

  }

  Future <Map<String,double>> getIncomeData() async {
    Map<String,double>inComeDataMap={};
    List<TransactionModel> transactionModels = [];
    transactionModels = await TransactionController.instance.readAllRecords();
    int count = 0;

    for(TransactionModel transactionModel in transactionModels){

      if(count==100)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString) {

        continue;
      }
      else{
        count++;
      }

      if(transactionModel.isIncome==1){
        if(inComeDataMap[transactionModel.category]==null) {
          inComeDataMap.putIfAbsent(transactionModel.category, () => transactionModel.amount);
        }
        else
        {

          inComeDataMap.update(transactionModel.category, (value) => value + transactionModel.amount);
        }
      }

    }


    return inComeDataMap;


      }

  Future <Map<String,double>> getAllData() async {
    Map<String,double>allDataMap={};


    List<TransactionModel> transactionModels = [];
    transactionModels = await TransactionController.instance.readAllRecords();
    int count = 0;

    for(TransactionModel transactionModel in transactionModels){

      if(count==100)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString) {

        continue;
      }
      else {
        count++;
      }


        if(allDataMap[transactionModel.category]==null) {
          allDataMap.putIfAbsent(transactionModel.category, () => transactionModel.amount);
        }
        else
        {
          allDataMap.update(transactionModel.category, (value) => value + transactionModel.amount);
        }


    }
    return allDataMap;


  }
  Future <Map<String,double>> getExpenseData() async {
    Map<String,double>dataMap={};


    List<TransactionModel> transactionModels = [];
    transactionModels = await TransactionController.instance.readAllRecords();
    int count = 0;

    for(TransactionModel transactionModel in transactionModels){

      if(count==100)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString) {

        continue;
      }
      else {
        count++;
      }

      if(transactionModel.isIncome==0){
        if(dataMap[transactionModel.category]==null) {
          dataMap.putIfAbsent(transactionModel.category, () => transactionModel.amount);
        }
        else
        {
          dataMap.update(transactionModel.category, (value) => value + transactionModel.amount);
        }
      }

    }
    return dataMap;


  }
  Future<double> getTotalExpense() async {
    double netExpense = 0;
    List<TransactionModel> transactionModels = [];
    transactionModels = await TransactionController.instance.readAllRecords();
    int count = 0;

    for(TransactionModel transactionModel in transactionModels){

      if(count==100)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString) {

        continue;
      }
      else {
        count++;
      }

      if(transactionModel.isIncome==0){
        netExpense += transactionModel.amount;
      }

    }


    return netExpense;


  }
  Future<double> getTotalIncome() async {
    double netIncome = 0;
    List<TransactionModel> transactionModels = [];
    transactionModels = await TransactionController.instance.readAllRecords();
    int count = 0;

    for(TransactionModel transactionModel in transactionModels){

      if(count==100)break;
      if(transactionModel.time==iniTime||transactionModel.category==debtString) {
        continue;
      }
      else {
        count++;
      }


      if(transactionModel.isIncome==1){
          netIncome += transactionModel.amount;


        }

      }


    return netIncome;

    }




  }











