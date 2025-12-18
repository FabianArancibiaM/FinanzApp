class Movement {
  final int? id;
  final double amount;
  final String category;
  final DateTime date;

  Movement({
    this.id,
    required this.amount,
    required this.category,
    required this.date,
  });

  bool get isIncome => amount > 0;
  bool get isExpense => amount < 0;
  
  double get absoluteAmount => amount.abs();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }

  Movement copyWith({
    int? id,
    double? amount,
    String? category,
    DateTime? date,
  }) {
    return Movement(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Movement(id: $id, amount: $amount, category: $category, date: $date)';
  }
}
