import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import 'widgets/export.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _selectedItem = "Penghasilan";

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildConditionalWidget(String selectedItem) {
    switch (selectedItem) {
      case 'Penghasilan':
        return const IncomeCalculatorWidget();
      case 'Emas':
        return const GoldCalculatorWidget();
      default:
        return Container(); // Return an empty container if no match is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        context,
        "Kalkulator",
        backIconFunction: () {
          context.read<CalculatorBloc>().add(InitialCalculatorEvent());
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              _buildConditionalWidget(_selectedItem),
            ],
          ),
        ),
      ),
    );
  }
}
