import 'dart:developer';

import 'package:kita_muslim/data/datasources/db/sqldatabases.dart';
import 'package:kita_muslim/data/models/hadits/hadistRange_model.dart' as range;
import 'package:kita_muslim/data/models/local/detail_surah_local_model.dart';
import 'package:kita_muslim/data/models/local/surah_local_model.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart'
    as spesifik;
import 'package:kita_muslim/data/models/surah/surah_model.dart' as surah;
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  final String dbName = 'dbmuslim.db';
  final String tableSurah = 'th_surah';
  final String tableDetailSurah = 'td_detailsurah';
  final String tableSurahUser = 'th_surah_user';
  final String tableMasterParameter = 'm_parameter';
  final String tableDailyPrayer = 'th_daily_prayer';

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
      name_short TEXT NULL,
      name_long TEXT NULL,
      name_transliteration_en TEXT NULL,
      name_transliteration_id TEXT NULL,
      name_translation_en TEXT NULL,
      name_translation_id TEXT NULL,
      revelation_arab TEXT NULL,
      revelation_en TEXT NULL,
      revelation_id TEXT NULL,
      tafsir_id TEXT NULL,    
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

    await db.execute('''
    CREATE TABLE $tableSurahUser    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      surah_number INTEGER,
      surah_name TEXT NULL,
      is_favorite INTEGER,
      total_verse INTEGER,
      last_verse_number INTEGER,
      active INTEGER      
      )
      ''');

    await db.execute('''
    CREATE TABLE $tableDailyPrayer    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,      
      title TEXT NULL,
      text_arab TEXT NULL,
      text_transliteration_en TEXT NULL,      
      translation_id TEXT NULL,
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

  // Future<List<surah.Data>> readAllSurah(
  Future<List<SurahLocalModel>> readAllSurah(
    Database? db,
    SqlDatabase instance,
  ) async {
    final db = await instance.database;

    String query = "";

    query =
        "select id,number,sequence,number_of_verses ,name_short,name_long ,transliteration_en,transliteration_id,translation_en,translation_id,revelation_arab,revelation_en,revelation_id,tafsir from $tableSurah ;";

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');
      return result.map((e) => SurahLocalModel.fromJson(e)).toList();
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<List<DetailSurahLocalModel>> readDetailSurah(
    Database? db,
    SqlDatabase instance,
    String number,
  ) async {
    final db = await instance.database;

    String query = "";

    query = """
        SELECT id,
       number,
       sequence,
       number_of_verses,
       name_short,
       name_long,
       name_transliteration_en,
       name_transliteration_id,
       name_translation_en,
       name_translation_id,
       revelation_arab,
       revelation_en,
       revelation_id,
       tafsir_id,
       prebismillah_arab,
       prebismillah_transliteration_en,
       prebismillah_translation_en,
       prebismillah_translation_id,
       prebismillah_audio_primary,
       prebismillah_audio_secondary_1,
       prebismillah_audio_secondary_2,
       number_inquran,
       number_insurah,
       juz,
       page,
       manzil,
       ruku,
       hizbquarter,
       sajda_recomended,
       sajda_obligatory,
       text_arab,
       text_transliteration_en,
       translation_en,
       translation_id,
       audio_primary,
       audio_secondary_0,
       audio_secondary_1,
       tafsir_id_short,
       tafsir_id_long
      FROM $tableDetailSurah
      where number = $number      
      order by abs(number_insurah)
      ;
        """;

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');
      return result.map((e) => DetailSurahLocalModel.fromJson(e)).toList();
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<int> readSurahUserExist(
    Database? db,
    SqlDatabase instance,
    int surahNumber,
  ) async {
    final db = await instance.database;

    String query = "";

    query = """
          select count(*) 
          from $tableSurahUser
          where surah_number = $surahNumber
        ;""";

    if (db != null) {
      final List<Map<String, Object?>> result =
          await db.rawQuery(''' $query ''');
      String hasil = result.first.values.first.toString();
      return int.parse(hasil);
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<int> readStatusFavoriteSurah(
    Database? db,
    SqlDatabase instance,
    int surahNumber,
  ) async {
    final db = await instance.database;

    String query = "";

    query = """
         SELECT is_favorite
          FROM $tableSurahUser
          WHERE surah_number = $surahNumber
          LIMIT 1
        ;""";

    if (db != null) {
      List<Map<String, dynamic>> result = await db.rawQuery(''' $query ''');
      // Periksa jika ada baris yang dikembalikan
      if (result.isNotEmpty) {
        // Jika ada, kembalikan nilai is_favorite
        return result[0]['is_favorite'] as int;
      } else {
        // Jika tidak ada, kembalikan 0
        return 0;
      }
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<int> readStatusLastVerseSurah(
    Database? db,
    SqlDatabase instance,
    int surahNumber,
  ) async {
    final db = await instance.database;

    String query = "";

    query = """
         SELECT last_verse_number
          FROM $tableSurahUser
          WHERE surah_number = $surahNumber
          LIMIT 1
        ;""";

    if (db != null) {
      List<Map<String, dynamic>> result = await db.rawQuery(''' $query ''');
      // Periksa jika ada baris yang dikembalikan
      if (result.isNotEmpty) {
        // Jika ada, kembalikan nilai is_favorite
        return result[0]['last_verse_number'] as int;
      } else {
        // Jika tidak ada, kembalikan 0
        return 0;
      }
    } else {
      throw Exception('DB is NULL');
    }
  }

  //  select is_favorite
  //         from $tableSurahUser
  //         where surah_number = $surahNumber
  //         LIMIT 1

  //  SELECT
  //       CASE
  //           WHEN COUNT(*) = 0 THEN 0
  //           ELSE MAX(is_favorite)
  //       END AS is_favorite
  //       FROM $tableSurahUser
  //         WHERE surah_number = $surahNumber;

  readSurahUser(
    Database? db,
    SqlDatabase instance,
    int surahNumber,
  ) async {
    final db = await instance.database;

    String query = "";

    query = """
          select 
              id,
              surah_number,
              surah_name,
              is_favorite,
              total_verse,
              last_verse_number,
              active
          from $tableSurahUser
          where surah_number = $surahNumber
          limit 1
        ;""";

    if (db != null) {
      final List<Map<String, Object?>> result =
          await db.rawQuery(''' $query ''');
      // BELUM SELESE
    } else {
      throw Exception('DB is NULL');
    }
  }

  /// INSERT

  Future<int> insertSurahHeader(
      Database? db, SqlDatabase instance, surah.Data data) async {
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

  Future<int> insertSurahDetail(
    Database? db,
    SqlDatabase instance,
    int number,
    int sequence,
    int numberOfVerses,
    spesifik.Data data,
    spesifik.Verses verse,
  ) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      // delete before if exist
      deleteSurahDetail(db, number, verse.number.inSurah);

      result = await db.rawInsert("""
      INSERT INTO $tableDetailSurah (number,
       sequence,
       number_of_verses,
       name_short,
       name_long,
       name_transliteration_en,
       name_transliteration_id,
       name_translation_en,
       name_translation_id,
       revelation_arab,
       revelation_en,
       revelation_id,
       tafsir_id,
       prebismillah_arab,
       prebismillah_transliteration_en,
       prebismillah_translation_en,
       prebismillah_translation_id,
       prebismillah_audio_primary,
       prebismillah_audio_secondary_1,
       prebismillah_audio_secondary_2,
       number_inquran,
       number_insurah,
       juz,
       page,
       manzil,
       ruku,
       hizbquarter,
       sajda_recomended,
       sajda_obligatory,
       text_arab,
       text_transliteration_en,
       translation_en,
       translation_id,
       audio_primary,
       audio_secondary_0,
       audio_secondary_1,
       tafsir_id_short,
       tafsir_id_long)
      VALUES
      (
        '$number'
      ,'$sequence'
      ,'$numberOfVerses'
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
      ,'${data.preBismillah?.text?.arab}'
      ,'${data.preBismillah?.text?.transliteration?.en}'
      ,'${data.preBismillah?.translation?.en}'
      ,'${data.preBismillah?.translation?.id}'
      ,'${data.preBismillah?.audio?.primary}'
      ,'${data.preBismillah?.audio?.secondary?[0]}'
      ,'${data.preBismillah?.audio?.secondary?[1]}'
      ,'${verse.number.inQuran}'      
      ,'${verse.number.inSurah}'
      ,'${verse.meta.juz}'
      ,'${verse.meta.page}'
      ,'${verse.meta.manzil}'
      ,'${verse.meta.ruku}'
      ,'${verse.meta.hizbQuarter}'
      ,'${verse.meta.sajda.recommended}'
      ,'${verse.meta.sajda.obligatory}'
      ,'${verse.text.arab}'
      ,'${verse.text.transliteration.en}'
      ,'${verse.translation.en}'
      ,'${verse.translation.id}'
      ,'${verse.audio.primary}'
      ,'${verse.audio.secondary[0]}'
      ,'${verse.audio.secondary[1]}'
      ,'${verse.tafsir.id["short"]}'
      ,'${verse.tafsir.id["long"]}'
      );
      """);
    }
    return result;
  }

  /// insert surah user
  Future<int> insertSurahUser(
    Database? db,
    SqlDatabase instance,
    int isFavorite,
    DetailSurahLocalModel data,
    int lastVerseNumber,
  ) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      result = await db.rawInsert("""
      INSERT INTO $tableSurahUser 
      (                              
            surah_number,
            surah_name,
            is_favorite,
            total_verse,
            last_verse_number,
            active
      )
      VALUES 
      (          
        '${data.number}'
        ,'${data.name_transliteration_id}'
        , $isFavorite
        , '${data.number_of_verses}'
        , $lastVerseNumber
        , '1'
      );
      """);
    }
    return (result > 0) ? 1 : -1;
  }

  /// UPDATE
  Future<int> updateFavoriteSurahUser(
    Database? db,
    SqlDatabase instance,
    int isFavorite,
    DetailSurahLocalModel data,
  ) async {
    final db = await instance.database;
    int result = 0;

    if (db != null) {
      result = await db.rawUpdate('''UPDATE $tableSurahUser
          SET
          is_favorite = ?         
          WHERE surah_number = ?''', [
        '$isFavorite',
        '${data.number}',
      ]);
    }
    return result;
  }

  Future<int> updateLastReadSurah(
    Database? db,
    SqlDatabase instance,
    int surahNumber,
    int lastReadSurahNumber,
  ) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      result = await db.rawUpdate('''
      UPDATE $tableSurahUser 
      SET
        last_verse_number = $lastReadSurahNumber
      WHERE 
        surah_number = ?
      ''', ['$surahNumber']);
    }
    return result;
  }

  /// END UPDATE

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
