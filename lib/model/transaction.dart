

class TransactionModel {
  int id;
  String accountName;
  int accountId;
  String time;
  double amount;
  String description;
  String category;
  int isIncome;

  TransactionModel({
    this.id,
    this.accountName,
    this.accountId,
    this.amount,
    this.category,
    this.time,
    this.isIncome,
    this.description,

  });

  factory TransactionModel.fromJson(Map<String, dynamic> jsonData) {
    return TransactionModel(
      id: jsonData['id'],
      accountName: jsonData['accountName'],
      amount: jsonData['amount'],
      category: jsonData['category'],
      accountId: jsonData['accountId'],
      time: jsonData['time'],
      isIncome: jsonData['isIncome'],
      description: jsonData['description'],

    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['accountName'] = accountName;
    data['amount'] = amount;
    data['category'] = category;
    data['accountId'] = accountId;
    data['time'] = time;
    data['isIncome'] = isIncome;
    data['description'] = description;
    return data;
  }
  TransactionModel copy({
    int id,
    String accountName,
    int accountId,
    String time,
    double amount,
    String description,
    String category,
    bool isIncome,

  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        accountName: accountName ?? this.accountName,
        time: time ?? this.time,
        accountId: accountId ?? this.accountId,
        description: description ?? this.description,
        category: category ?? this.category,
        isIncome: isIncome ?? this.isIncome,

      );

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'transaction{id: $id, name: $accountName, amount: $amount, time: $time}';
  }

}