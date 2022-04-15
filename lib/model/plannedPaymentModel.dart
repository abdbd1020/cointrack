

class PlannedPayment {
  int id;
  String recurrence;
  String date;
  String lastDate;
  int transactionId;
  double amount;
  static final List<String> values = [
    /// Add all fields
    "id", "transactionId", "amount", "name","dueDate","isLend"
  ];

  PlannedPayment({
    this.id,
    this.date,
    this.transactionId,
    this.lastDate,
    this.amount,


    this.recurrence

  });

  factory PlannedPayment.fromJson(Map<String, dynamic> jsonData) {
    return PlannedPayment(
      id: jsonData['id'],
      transactionId: jsonData['transactionId'],
      date: jsonData['date'],
      recurrence: jsonData['recurrence'],
      lastDate: jsonData['lastDate'],
      amount: jsonData['amount'],

    );
  }


  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['transactionId'] = transactionId;
    data['lastDate'] = lastDate;
    data['date'] = date;
    data['recurrence'] = recurrence;
    data['amount'] = amount;

    return data;
  }
  PlannedPayment copy({
    int id,
    String transactionId,
    String lastDate,
    String date,
    String recurrence,
    String amount,



  }) =>
      PlannedPayment(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        date: date ?? this.date,
        recurrence: date ?? this.recurrence,
        lastDate: date ?? this.lastDate,
        amount: amount ?? this.amount,

      );

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'transaction{id: $id,  name: $transactionId}';
  }

}