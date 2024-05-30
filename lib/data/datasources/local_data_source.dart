import 'package:kita_muslim/data/datasources/db/sqldatabases.dart';

abstract class LocalDataSource {
  // getInitCategory();
//   Future<List<CategoryModel>> readCategory(int isDefault);
//   Future<List<CategoryModel>> readOpsCategory(int isDefault);
//   Future<CategoryModel> readCategoryById(int idCategory);
//   Future<int> createCategory(Category value);
//   Future<int> updateCategory(int idCategory, Category valueCategory);
//   Future<void> deleteCategory(int idCategory);
//   Future<int> createNewTransaction(Transaction value);
//   Future<List<TransactionModel>> readTransaction(String date);
//   Future<List<CalculationModel>> readCalculation(String date);
//   Future<List<ChartCalculationModel>> readChartDefault(
//       String date, int isOutcome, OptionDate optionDate);
//   Future<void> deleteTransaction(int idTransaction);
//   Future<int> updateTransaction(
//       int idTransaction, Transaction valueTransaction);
//   Future<void> deleteAllData();
  // Future<bool>
  readSurah();

//   // parameter
//   Future<List<Map<String, dynamic>>> readParamThemes();
//   Future<int> updateParamThemes(String value);
//   Future<bool> savingPasscode(String value);
//   Future<String> readPasscodeFromDB();
//   Future<List<String>> readAllYearTransaction();
//   // Future<bool> updateParamThemes(String value);

//   // report
//   Future<List<ReportModel>> generatedTransactionByYear(String year);
}

class LocalDataSourceImpl implements LocalDataSource {
  final dbprovider = SqlDatabase.instance;

  // @override
  // getInitCategory() {
  //   final result = dbprovider.database;
  // }

  // @override
  // Future<List<CategoryModel>> readCategory(int isDefault) async {
  //   return await dbprovider.readCategory(isDefault);
  // }

  // // read ops category
  // @override
  // Future<List<CategoryModel>> readOpsCategory(int isDefault) async {
  //   return await dbprovider.readOpsCategory(isDefault);
  // }

  // @override
  // Future<CategoryModel> readCategoryById(int idCategory) async {
  //   return await dbprovider.readCategoryById(idCategory);
  // }

  // @override
  // Future<int> createCategory(Category value) async {
  //   return await dbprovider.createCategory(value);
  // }

  // @override
  // Future<int> updateCategory(int idCategory, Category valueCategory) async {
  //   return await dbprovider.updateCategory(idCategory, valueCategory);
  // }

  // @override
  // Future<void> deleteCategory(int idCategory) async {
  //   await dbprovider.deleteCategory(idCategory);
  // }

  // // delete all data
  // @override
  // Future<void> deleteAllData() async {
  //   return await dbprovider.deleteAllData();
  // }

  // @override
  // Future<void> deleteTransaction(int idTransaction) async {
  //   await dbprovider.deleteTransaction(idTransaction);
  // }

  // @override
  // Future<int> createNewTransaction(Transaction value) async {
  //   return await dbprovider.createNewTransaction(value);
  // }

  // @override
  // Future<List<TransactionModel>> readTransaction(String date) async {
  //   return await dbprovider.readTransaction(date);
  // }

  // @override
  // Future<List<CalculationModel>> readCalculation(String date) async {
  //   return await dbprovider.readCalculation(date);
  // }

  // @override
  // Future<List<ChartCalculationModel>> readChartDefault(
  //     String date, int isOutcome, OptionDate optionDate) async {
  //   return await dbprovider.readChartDefault(date, isOutcome, optionDate);
  // }

  // @override
  // Future<int> updateTransaction(
  //     int idTransaction, Transaction valueTransaction) async {
  //   return await dbprovider.updateTransaction(idTransaction, valueTransaction);
  // }

  // @override
  // Future<List<Map<String, dynamic>>> readParamThemes() async {
  //   return await dbprovider.readParamThemes();
  // }

  // @override
  // Future<int> updateParamThemes(String value) async {
  //   return await dbprovider.updateThemes(value);
  // }

  @override
  readSurah() async {
    return await dbprovider.readSurah();
  }

  // @override
  // Future<bool> savingPasscode(String value) async {
  //   return await dbprovider.savingNewPasscode(value);
  // }

  // @override
  // Future<String> readPasscodeFromDB() async {
  //   return await dbprovider.readPasscodeValue();
  // }

  // @override
  // Future<List<String>> readAllYearTransaction() async {
  //   return await dbprovider.readAllYearTransaction();
  // }

  // @override
  // Future<List<ReportModel>> generatedTransactionByYear(String year) async {
  //   return await dbprovider.generateReportYearly(year);
  // }
}
