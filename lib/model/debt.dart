

class Debt {
  int id;
  int transactionId;
  double amount;
  String name;
  String dueDate;
  int isLend;

  Debt({
    this.id,
    this.amount,
    this.name,
    this.transactionId,
    this.isLend,
    this.dueDate

  });

  factory Debt.fromJson(Map<String, dynamic> jsonData) {
    return Debt(
      id: jsonData['id'],
      name: jsonData['name'],
      transactionId: jsonData['transactionId'],
      isLend: jsonData['isLend'],
      dueDate: jsonData['dueDate'],
      amount: jsonData['amount'],

    );
  }


  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['transactionId'] = transactionId;
    data['isLend'] = isLend;
    data['dueDate'] = dueDate;
    data['amount'] = amount;

    return data;
  }
  Debt copy({
    int id,
    String name,
    int transactionId,
    String isLend,
    String dueDate,
    String amount,


  }) =>
      Debt(
        id: id ?? this.id,
        name: name ?? this.name,
        transactionId: transactionId ?? this.transactionId,
        isLend: isLend ?? this.isLend,
        dueDate: dueDate ?? this.dueDate,
        amount: amount ?? this.amount,

      );

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'transaction{id: $id, name: $transactionId, amount: $isLend, name: $name}';
  }

}