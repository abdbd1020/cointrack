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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type' : type,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, amount: $amount, type: $type}';
  }
}