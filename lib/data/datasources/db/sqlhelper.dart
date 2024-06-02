import 'package:kita_muslim/data/datasources/db/sqldatabases.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart'
    as spesifik;
import 'package:sqflite/sqflite.dart';

import '../../models/surah/surah_model.dart';

class SqlHelper {
  final String dbName = 'dbmuslim.db';
  final String tableSurah = 'th_surah';
  final String tableDetailSurah = 'td_detailsurah';
  final String tableMasterParameter = 'm_parameter';

  // init tables
  initDB(Database db) async {
    //create table transaction
    await db.execute('''
    CREATE TABLE $tableSurah    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      number TEXT NULL,
      sequence TEXT NULL,
      number_of_verses TEXT NULL,
      name_short TEXT NULL,
      name_long TEXT NULL,
      transliteration_en TEXT NULL,
      transliteration_id TEXT NULL,
      translation_en TEXT NULL,
      translation_id TEXT NULL,
      revelation_arab TEXT NULL,
      revelation_en TEXT NULL,
      revelation_id TEXT NULL,
      tafsir TEXT NULL
      )
      ''');

    // create table master category
    await db.execute('''
    CREATE TABLE $tableDetailSurah    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      number TEXT NULL,
      sequence TEXT NULL,
      number_of_verses TEXT NULL,
      prebismillah_arab TEXT NULL,
      prebismillah_transliteration_en TEXT NULL,
      prebismillah_translation_en TEXT NULL,
      prebismillah_translation_id TEXT NULL,
      prebismillah_audio_primary TEXT NULL,
      prebismillah_audio_secondary_1 TEXT NULL,
      prebismillah_audio_secondary_2 TEXT NULL,
      number_inquran TEXT NULL,
      number_insurah TEXT NULL,
      juz TEXT NULL,
      page TEXT NULL,
      manzil TEXT NULL,
      ruku TEXT NULL,
      hizbquarter TEXT NULL,
      sajda_recomended TEXT NULL,
      sajda_obligatory TEXT NULL,
      text_arab TEXT NULL,
      text_transliteration_en TEXT NULL,      
      translation_en TEXT NULL,
      translation_id TEXT NULL,
      audio_primary TEXT NULL,
      audio_secondary_0 TEXT NULL,
      audio_secondary_1 TEXT NULL,
      tafsir_id_short TEXT NULL,
      tafsir_id_long TEXT NULL
      )
      ''');

    // create table master parameter
    // await db.execute('''
    // CREATE TABLE $tableMasterParameter    (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   name TEXT NOT NULL,
    //   value TEXT NULL,
    //   actived INTEGER,
    //   description TEXT NULL
    //   )
    //   ''');
  }

  // init default value tables
  initDefaultDB(Database db) {
    // inserMasterCategory(
    //     db, tableMasterCategory); // insert default master category
    // inserMasterColors(db, tableMasterColors); // insert default master category
    // insertMasterParameter(db, tableMasterParameter); // insert master parameter
  }

  // // read all category
  // Future<List<CategoryModel>> readCategory(
  //     Database? db, SqlDatabase instance, int isDefault) async {
  //   final db = await instance.database;

  //   String query = "";
  //   if (isDefault == 0) {
  //     query =
  //         "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableMasterCategory ;";
  //   } else {
  //     query =
  //         "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableMasterCategory where isDefault = 1 ;";
  //   }

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');

  //     return result.map((e) => CategoryModel.fromJson(e)).toList();
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // // read ops category
  // Future<List<CategoryModel>> readOpsCategory(
  //     Database? db, SqlDatabase instance, int isDefault) async {
  //   final db = await instance.database;

  //   String query = "";
  //   if (isDefault == 0) {
  //     query =
  //         "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableOpsCategory ;";
  //   } else {
  //     query =
  //         "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableOpsCategory where isDefault = 1 ;";
  //   }

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');

  //     return result.map((e) => CategoryModel.fromJson(e)).toList();
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // // read category by id
  // Future<CategoryModel> readCategoryById(
  //     Database? db, SqlDatabase instance, int idCategory) async {
  //   final db = await instance.database;

  //   String query =
  //       "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableOpsCategory where id = $idCategory ;";

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');

  //     return result.map((e) => CategoryModel.fromJson(e)).toList().first;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // Future<int> createCategory(
  //     Database? db, SqlDatabase instance, Category category) async {
  //   final db = await instance.database;
  //   int result = 0;
  //   if (db != null) {
  //     result = await db.rawInsert('''
  //     INSERT INTO $tableOpsCategory (name, iconName,createdTime, modifieldTime, isDefault)
  //     VALUES
  //     (
  //       '${category.name}'
  //       ,'${category.iconName}'
  //       ,'${category.createdTime}'
  //       ,'${category.modifieldTime}'
  //       ,'${category.isDefault}'
  //       );
  //     ''');
  //   }
  //   return result;
  // }

  // Future<int> updateCategory(Database? db, SqlDatabase instance, int idCategory,
  //     Category valueCategory) async {
  //   final db = await instance.database;
  //   int result = 0;

  //   if (db != null) {
  //     return result = await db.rawUpdate('''UPDATE $tableOpsCategory
  //         SET
  //         name = ?
  //         , iconName = ?
  //         , createdTime = ?
  //         , modifieldTime = ?
  //         , isDefault = ?
  //         WHERE id = ?''', [
  //       valueCategory.name,
  //       valueCategory.iconName,
  //       valueCategory.createdTime,
  //       valueCategory.modifieldTime,
  //       valueCategory.isDefault,
  //       '$idCategory'
  //     ]);
  //   }
  //   return result;
  // }

  // Future<void> deleteCategoryByID(Database? db, int idCategory) async {
  //   if (db != null) {
  //     await db.rawDelete('''
  //     DELETE FROM $tableOpsCategory WHERE id = ? ''', [idCategory]);
  //   }
  // }

  // Future<void> deleteAllData(Database? db) async {
  //   if (db != null) {
  //     await db.rawDelete(''' DELETE FROM $tableTransaction ; ''');
  //     await db.rawDelete(
  //         ''' DELETE FROM $tableOpsCategory where isDefault != 1; ''');
  //   }
  // }

  // Future<int> createNewTransaction(Database? db, SqlDatabase instance,
  //     trx.Transaction valueTransaction) async {
  //   final db = await instance.database;
  //   int result = 0;
  //   if (db != null) {
  //     result = await db.rawInsert('''
  //     INSERT INTO $tableTransaction (isOutcome, idCategory, title, description, amount, idWallet, createdTime, isModifield, modifieldTrxTime)
  //     VALUES
  //     (
  //       '${valueTransaction.isOutcome}'
  //       ,'${valueTransaction.idCategory}'
  //       ,'${valueTransaction.title}'
  //       ,'${valueTransaction.description}'
  //       ,'${valueTransaction.amount}'
  //       ,'${valueTransaction.idWallet}'
  //       ,'${valueTransaction.createdTime}'
  //       ,'${valueTransaction.isModifield}'
  //       ,'${valueTransaction.modifieldTrxTime}'
  //       );
  //     ''');
  //   }
  //   return result;
  // }

  Future<int> insertSurahHeader(
      Database? db, SqlDatabase instance, Data data) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      result = await db.rawInsert('''
      INSERT INTO $tableSurah (number,sequence,number_of_verses,name_short,name_long,transliteration_en,transliteration_id,translation_en,translation_id,revelation_arab,revelation_en,revelation_id,tafsir)
      VALUES
      (
        '${data.number}'
      ,'${data.sequence}'
      ,'${data.numberOfVerses}'
      ,'${data.name.short}'
      ,'${data.name.long}'
      ,'${data.name.transliteration.en}'
      ,'${data.name.transliteration.id}'
      ,'${data.name.translation.en}'
      ,'${data.name.translation.id}'
      ,'${data.revelation.arab}'
      ,'${data.revelation.en}'
      ,'${data.revelation.id}'      
      ,'${data.tafsir.id}'
      );
      ''');
    }
    return result;
  }

  Future<int> insertSurahDetail(Database? db, SqlDatabase instance, int number,
      int sequence, int numberOfVerses, spesifik.PreBismillah? preBismillah, spesifik.Verses data) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      deleteSurahDetail(db, number, data.number.inSurah);

      result = await db.rawInsert('''
      INSERT INTO $tableDetailSurah (number, sequence, number_of_verses, prebismillah_arab, prebismillah_transliteration_en, prebismillah_translation_en, prebismillah_translation_id, prebismillah_audio_primary, prebismillah_audio_secondary_1, prebismillah_audio_secondary_2, number_inquran, number_insurah, juz, page, manzil, ruku, hizbquarter, sajda_recomended, sajda_obligatory, text_arab, text_transliteration_en, translation_en, translation_id, audio_primary, audio_secondary_0, audio_secondary_1, tafsir_id_short, tafsir_id_long)
      VALUES
      (
        '$number'
      ,'$sequence'
      ,'$numberOfVerses'
      ,'${preBismillah?.text?.arab}'
      ,'${preBismillah?.text?.transliteration?.en}'
      ,'${preBismillah?.translation?.en}'
      ,'${preBismillah?.translation?.id}'
      ,'${preBismillah?.audio?.primary}'
      ,'${preBismillah?.audio?.secondary?[0]}'
      ,'${preBismillah?.audio?.secondary?[1]}'
      ,'${data.number.inQuran}'
      ,'${data.number.inSurah}'
      ,'${data.meta.juz}'
      ,'${data.meta.page}'
      ,'${data.meta.manzil}'
      ,'${data.meta.ruku}'
      ,'${data.meta.hizbQuarter}'
      ,'${data.meta.sajda.recommended}'
      ,'${data.meta.sajda.obligatory}'
      ,'${data.text.arab}'
      ,'${data.text.transliteration.en}'
      ,'${data.translation.en}'
      ,'${data.translation.id}'
      ,'${data.audio.primary}'
      ,'${data.audio.secondary[0]}'
      ,'${data.audio.secondary[1]}'
      ,'${data.tafsir.id["short"]}'
      ,'${data.tafsir.id["long"]}'
      );
      ''');
    }
    return result;
  }

  Future<void> deleteSurahDetail(Database? db, int number, int inSurah) async {
    if (db != null) {
      await db.rawDelete('''
      DELETE FROM $tableDetailSurah WHERE number = ? and number_insurah = ? ''',
          [number, inSurah]);
    }
  }

  //  "${data.number}"
  //     ,"${data.sequence}"
  //     ,"${data.numberOfVerses}"
  //     ,"${data.name.short}"
  //     ,"${data.name.long}"
  //     ,"${data.name.transliteration.en}"
  //     ,"${data.name.transliteration.id}"
  //     ,"${data.name.translation.en}"
  //     ,"${data.name.translation.id}"
  //     ,"${data.revelation.arab}"
  //     ,"${data.revelation.en}"
  //     ,"${data.revelation.id}"
  //     ,"${data.tafsir.id.replaceAll("'", "`").replaceAll('"', '`')}"

  // // Future<List<TransactionModel>>
  // Future<List<TransactionModel>> readTransaction(
  //     Database? db, SqlDatabase instance,
  //     {required String date}) async {
  //   String query = """select tr.id
  //           ,tr.isOutcome
  //           ,tr.idCategory
  //           ,tr.title
  //           ,tr.description
  //           ,tr.amount
  //           ,tr.idWallet
  //           ,tr.createdTime
  //           ,tr.isModifield
  //           ,tr.modifieldTrxTime
  //           ,mc.name as categoryName
  //           ,mc.iconName as categoryIconName
  //         from $tableTransaction tr join $tableOpsCategory mc on tr.idCategory = mc.id where tr.createdTime like '%$date%'
  //         ;""";
  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');
  //     final datas = result.map((e) => TransactionModel.fromJson(e)).toList();
  //     return datas;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // Future<List<CalculationModel>> readCalculation(
  //     Database? db, SqlDatabase instance,
  //     {required String date}) async {
  //   String query = """
  //    SELECT
  //     CAST(IFNULL(sum(income),0.0) as double) as income,
  //     CAST(IFNULL(sum(expense),0.0) as double) as expense,
  //     CAST(IFNULL(sum(income) ,0.0)- IFNULL(sum(expense) ,0.0) as double) as profit
  //   from (
  //           SELECT
  //           IFNULL(aa.amount,0.0) as income
  //           , IFNULL(0.0,0.0) as expense
  // 		      , aa.createdTime as createdTime
  //           from th_transaction aa
  // 		left JOIN ops_category bb on aa.idCategory = bb.id
  //           where
  //           aa.isOutcome = 0
  //           and aa.createdTime like '%$date%'
  //         UNION ALL
  //         SELECT
  //           IFNULL(0,0.0) as income
  //           , IFNULL(a.amount,0.0) as expense
  // 		      , a.createdTime as createdTime
  //           from th_transaction a
  // 		 JOIN ops_category b on a.idCategory = b.id
  //           where
  //           a.isOutcome = 1
  //           and a.createdTime like '%$date%'
  //         )
  //     """;

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');

  //     final datas = result.map((e) => CalculationModel.fromJson(e)).toList();
  //     return datas;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // Future<List<ChartCalculationModel>> readChartDefault(
  //   Database? db,
  //   SqlDatabase instance, {
  //   required String date,
  //   required OptionDate optionDate,
  //   required int isOutcome,
  // }) async {
  //   String dateSub = "";

  //   switch (optionDate) {
  //     case OptionDate.month:
  //       dateSub = date.substring(0, 7);
  //       break;
  //     default:
  //       dateSub = date.substring(0, 7);
  //   }

  //   String query = """
  //       select
  //     A.categoryName as categoryName
  //     , A.amount as amount
  //     , A.persentase as persentase
  //     , B.int_code  as colors
  //   from
  //   (
  //     select
  //       row_number() over (order by ct.name) as row_num
  //       ,ct.name as categoryName
  //       , sum(trx.amount) as amount
  //       , round(sum(trx.amount) * 100.0 / sum(sum(trx.amount)) over(),2) as persentase
  //     from $tableTransaction trx
  //     join $tableOpsCategory ct on ct.id = trx.idCategory
  //       where
  //         trx.idCategory <> 0
  //         and trx.isOutcome = $isOutcome
  //         and trx.createdTime like '%$dateSub%'
  //         group by ct.name
  //   ) A
  //   join
  //   (
  //     select
  //       row_number() over (order by name) as row_num
  //       , id
  //       , name
  //       , hex_code
  //       , int_code
  //       , rgb_code

  //     from $tableMasterColors
  //   ) B
  //   on  A.row_num=B.row_num
  //   ORDER BY A.persentase
  //   """;

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');
  //     final datas =
  //         result.map((e) => ChartCalculationModel.fromJson(e)).toList();
  //     return datas;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // // delete transaction
  // Future<void> deleteTransactionByID(Database? db, int idTransaction) async {
  //   if (db != null) {
  //     await db.rawDelete('''
  //     DELETE FROM $tableTransaction WHERE id = ? ''', [idTransaction]);
  //   }
  // }

  // // update transaction
  // Future<int> updateTransaction(Database? db, SqlDatabase instance,
  //     int idTransaction, trx.Transaction valueTransaction) async {
  //   final db = await instance.database;
  //   int result = 0;

  //   if (db != null) {
  //     result = await db.rawUpdate('''UPDATE $tableTransaction
  //         SET
  //         isOutcome = ?
  //         , idCategory = ?
  //         , title = ?
  //         , description = ?
  //         , amount = ?
  //         , idWallet = ?
  //         , createdTime = ?
  //         , isModifield = ?
  //         , modifieldTrxTime = ?
  //         WHERE id = ?''', [
  //       valueTransaction.isOutcome,
  //       valueTransaction.idCategory,
  //       valueTransaction.title,
  //       valueTransaction.description,
  //       valueTransaction.amount,
  //       valueTransaction.idWallet,
  //       valueTransaction.createdTime,
  //       valueTransaction.isModifield,
  //       valueTransaction.modifieldTrxTime,
  //       '$idTransaction'
  //     ]);
  //   }
  //   return result;
  // }

  // // --- parameter ---
  // // read parameter themes
  // Future<List<Map<String, dynamic>>> readParamThemes(
  //     Database? db, SqlDatabase instance) async {
  //   final db = await instance.database;

  //   String query = """select value from $tableMasterParameter
  //       where name = 'isDark' limit 1 ;""";

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');
  //     return result;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // // read passcode exist
  Future<String> readNumberOfSurah(Database? db, SqlDatabase instance) async {
    final db = await instance.database;

    String query = """ select count(id) from $tableSurah ; """;

    if (db != null) {
      final result = await db.rawQuery(''' $query''');

      String countData = result.first.values.first.toString();
      // print(">>> countData : $countData");

      // return (result.first.values.first.toString() == defaultPasscode) // 00000
      //     ? false
      //     : true;
      return countData;
    } else {
      throw Exception('DB is null');
    }
  }

  // // read passcode value
  // Future<String> readParamPasscodeValue(
  //     Database? db, SqlDatabase instance) async {
  //   final db = await instance.database;

  //   String query =
  //       """ select value from $tableMasterParameter where name = 'user_passcode' limit 1; """;

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query''');
  //     return result.first.values.first.toString();
  //   } else {
  //     throw Exception('DB is null');
  //   }
  // }

  // // update parameter themes
  // Future<int> updateParamThemes(
  //     Database? db, SqlDatabase instance, String valueParam) async {
  //   final db = await instance.database;
  //   int result = 0;

  //   if (db != null) {
  //     result = await db.rawUpdate("""UPDATE $tableMasterParameter
  //         SET
  //         value = ?
  //         WHERE name = 'isDark' """, [valueParam]);
  //   }
  //   return result;
  // }

  // // read passcode exist
  // Future<bool> savingNewPasscode(
  //   Database? db,
  //   SqlDatabase instance,
  //   String valuePasscode,
  // ) async {
  //   final db = await instance.database;
  //   int result = 0;

  //   if (db != null) {
  //     result = await db.rawUpdate("""UPDATE $tableMasterParameter
  //         SET
  //         value = ?
  //         WHERE name = 'user_passcode'
  //         and actived = 1
  //         """, [valuePasscode]);
  //   }
  //   return (result == 1) ? true : false;
  // }
  // // -- end paramter ----------------------------------------------------------

  // // read all year transaction
  // Future<List<String>> readAllYearTransaction(
  //   Database? db,
  //   SqlDatabase instance,
  // ) async {
  //   final db = await instance.database;
  //   List<String> result = [];
  //   String query =
  //       """ select strftime('%Y', createdTime) from th_transaction GROUP by strftime('%Y', createdTime) order by createdTime desc; """;

  //   if (db != null) {
  //     final datas = await db.rawQuery(''' $query''');
  //     for (var element in datas) {
  //       result.add(element.values.first.toString());
  //     }
  //   }
  //   return result;
  // }

  // // ----------------- REPORT ------------------------------------
  // Future<List<ReportModel>> generateReportByYear(
  //   Database? db,
  //   SqlDatabase instance, {
  //   required String year,
  // }) async {
  //   String query = """
  //     SELECT
  //     strftime('%Y-%m', createdTime) as year_month,
  //     CAST(IFNULL(sum(income),0.0) as double) as income,
  //     CAST(IFNULL(sum(expense),0.0) as double) as expense,
  //     CAST(IFNULL(sum(income) ,0.0)- IFNULL(sum(expense) ,0.0) as double) as profit
  //   from (
  //        SELECT
  //           IFNULL(aa.amount,0.0) as income
  //           , IFNULL(0.0,0.0) as expense
  // 		      , aa.createdTime as createdTime
  //           from th_transaction aa
  // 		left JOIN ops_category bb on aa.idCategory = bb.id
  //           where
  //           aa.isOutcome = 0
  //           and aa.createdTime like '%$year%'
  //         UNION ALL
  //         SELECT
  //           IFNULL(0,0.0) as income
  //           , IFNULL(a.amount,0.0) as expense
  // 		      , a.createdTime as createdTime
  //           from th_transaction a
  // 		 JOIN ops_category b on a.idCategory = b.id
  //           where
  //           a.isOutcome = 1
  //           and a.createdTime like '%$year%'
  //         )
  // 	  group by year_month
  // 	  order by year_month desc
  //     """;

  //   if (db != null) {
  //     final result = await db.rawQuery(''' $query ''');
  //     final datas = result.map((e) => ReportModel.fromJson(e)).toList();
  //     return datas;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }
}
