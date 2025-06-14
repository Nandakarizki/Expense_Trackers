import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/entities/entities.dart';

import '../models/models.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  int amount;
  String description;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
    required this.description,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
      'description': description,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'],
      category:
          Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'],
      description: doc['description'] ?? '',
    );
  }
}
