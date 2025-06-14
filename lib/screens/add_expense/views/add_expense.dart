import 'package:apps/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:apps/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:apps/screens/add_expense/views/category_creation.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late Expense expense;
  bool isLoading = false;
  bool isExpense = true;

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          onPressed: (int index) {
                            setState(() {
                              isExpense = index == 0;
                            });
                          },
                          isSelected: [isExpense, !isExpense],
                          fillColor: isExpense
                              ? Colors.red[100]
                              : Colors.green[100],
                          splashColor: isExpense
                              ? Colors.red[200]
                              : Colors.green[200],
                          borderRadius: BorderRadius.circular(10),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('Pengeluaran'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('Pemasukan'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isExpense ? "Add Expense" : "Add Income",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: expenseController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                FontAwesomeIcons.rupiahSign,
                                size: 16,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidMessage,
                              size: 16,
                              color: Colors.grey,
                            ),
                            hintText: 'Deskripsi (contoh: Gaji bulanan)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (isExpense) ...[
                          TextFormField(
                            controller: categoryController,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: true,
                            onTap: () {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: expense.category == Category.empty
                                  ? Colors.white
                                  : Color(expense.category.color),
                              prefixIcon: expense.category == Category.empty
                                  ? const Icon(
                                      FontAwesomeIcons.list,
                                      size: 16,
                                      color: Colors.grey,
                                    )
                                  : Image.asset(
                                      'assets/${expense.category.icon}.png',
                                      scale: 2,
                                    ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  var newCategory = await getCategoryCreation(
                                    context,
                                  );
                                  if (newCategory != null) {
                                    setState(() {
                                      state.categories.insert(0, newCategory);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Category',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: ListView.builder(
                              itemCount: state.categories.length,
                              itemBuilder: (context, int i) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        expense.category = state.categories[i];
                                        categoryController.text =
                                            expense.category.name;
                                      });
                                    },
                                    leading: Image.asset(
                                      'assets/${state.categories[i].icon}.png',
                                      scale: 2,
                                    ),
                                    title: Text(state.categories[i].name),
                                    tileColor: Color(state.categories[i].color),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: dateController,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: expense.date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );

                            if (newDate != null) {
                              setState(() {
                                dateController.text = DateFormat(
                                  'dd/MM/yyyy',
                                ).format(newDate);
                                expense.date = newDate;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.clock,
                              size: 16,
                              color: Colors.grey,
                            ),
                            hintText: 'Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: kToolbarHeight,
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : TextButton(
                                  onPressed: () {
                                    if (isExpense) {
                                      expense.amount = -int.parse(
                                        expenseController.text,
                                      );
                                    } else {
                                      expense.amount = int.parse(
                                        expenseController.text,
                                      );
                                      expense.category = Category(
                                        categoryId: 'income',
                                        name: 'Pemasukan',
                                        totalExpenses: 0,
                                        icon: 'income',
                                        color: Colors.green.value,
                                      );
                                    }

                                    expense.description =
                                        descriptionController.text;

                                    context.read<CreateExpenseBloc>().add(
                                      CreateExpense(expense),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
