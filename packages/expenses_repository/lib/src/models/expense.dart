import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  int amount;
  String description;

  Expense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
    required this.description,
  });

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
    description: '',
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      category: category,
      date: date,
      amount: amount,
      description: description,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      category: entity.category,
      date: entity.date,
      amount: entity.amount,
      description: entity.description,
    );
  }
}
