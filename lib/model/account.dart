

class Account {
  final int id;
  final String name;
  final int amount;
  final String type;

  const Account({
    this.id,
     this.name,
     this.amount,
      this.type,
  });

  factory Account.fromJson(Map<String, dynamic> jsonData) {
    return Account(
      id: jsonData['id'],
      name: jsonData['name'],
      amount: jsonData['amount'],
      type: jsonData['type'],

    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
  Account copy({
    int id,
    double amount,
    String name,
    String type,

  }) =>
      Account(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        name: name ?? this.name,
        type: type ?? this.type,

      );

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, amount: $amount, type: $type}';
  }
}