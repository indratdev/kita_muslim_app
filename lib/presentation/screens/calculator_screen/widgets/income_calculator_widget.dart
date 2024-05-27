import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/widgets/textformfied_custom.dart';

class IncomeCalculatorWidget extends StatefulWidget {
  const IncomeCalculatorWidget({super.key});

  @override
  State<IncomeCalculatorWidget> createState() => _IncomeCalculatorWidgetState();
}

class _IncomeCalculatorWidgetState extends State<IncomeCalculatorWidget> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();

  @override
  void dispose() {
    _incomeController.dispose();
    _expensesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.blue,
        child: Column(
          children: [
            CustomTextfieldWidget(
              controller: _incomeController,
            ),
            CustomTextfieldWidget(
              controller: _expensesController,
            )
          ],
        ),
      ),
    );
  }
}
