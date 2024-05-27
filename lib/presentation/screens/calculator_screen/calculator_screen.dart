import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kita_muslim/presentation/screens/calculator_screen/widgets/income_calculator_widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();

  String _selectedItem = "Penghasilan";

  @override
  void dispose() {
    _incomeController.dispose();
    _expensesController.dispose();
    super.dispose();
  }

  Widget _buildConditionalWidget(String selectedItem) {
    switch (selectedItem) {
      case 'Penghasilan':
        return IncomeCalculatorWidget();
      // Expanded(
      //   child: Container(
      //     margin: const EdgeInsets.only(top: 21),
      //     color: Colors.amber,
      //     child: Center(
      //       child: Text(
      //         'Penghasilan selected',
      //         style: TextStyle(fontSize: 24),
      //       ),
      //     ),
      //   ),
      // );
      case 'Perusahaan':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 21),
            color: Colors.blue,
            child: Center(
              child: Text(
                'Perusahaan selected',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      case 'Perdagangan':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 21),
            color: Colors.green,
            child: Center(
              child: Text(
                'Perdagangan selected',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      case 'Emas':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 21),
            color: Colors.yellow,
            child: Center(
              child: Text(
                'Emas selected',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      default:
        return Container(); // Return an empty container if no match is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Jenis Zakat :',
                border: OutlineInputBorder(),
              ),
              items: [
                'Penghasilan',
                'Perusahaan',
                'Perdagangan',
                'Emas',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // TextField(
            //   controller: _incomeController,
            //   decoration: const InputDecoration(
            //     labelText: 'Penghasilan',
            //     border: OutlineInputBorder(),
            //   ),
            //   keyboardType: TextInputType.number,
            // ),
            // const SizedBox(height: 20),
            // TextField(
            //   controller: _expensesController,
            //   decoration: const InputDecoration(
            //     labelText: 'Pengeluaran',
            //     border: OutlineInputBorder(),
            //   ),
            //   keyboardType: TextInputType.number,
            // ),
            const SizedBox(height: 20),
            _buildConditionalWidget(_selectedItem),
          ],
        ),
      ),
    );
  }
}
