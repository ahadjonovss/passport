import 'dart:io';

import 'package:flutter_excel/excel.dart';
import 'package:hive/hive.dart';
import 'package:open_filex/open_filex.dart';
import 'package:passport/data/model/person_adapter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HiveRepository {
  void savePerson(PersonModel person) {
    final personBox = Hive.box<PersonModel>('personBox');
    personBox.add(person);
  }

  void deleteData() {
    final personBox = Hive.box<PersonModel>('personBox');
    personBox.clear();
  }

  List<PersonModel> readAllData() {
    final personBox = Hive.box<PersonModel>('personBox');
    List<PersonModel> allData = [];

    for (var i = 0; i < personBox.length; i++) {
      final person = personBox.getAt(i);
      if (person != null) {
        allData.add(person);
      }
    }

    return allData;
  }

  Future<void> generateExcel(int count) async {
    // Create a new Excel workbook
    var excel = Excel.createExcel();

    // Create a worksheet
    Sheet sheetObject = excel['Sheet1'];

    // Write headers to the worksheet
    sheetObject.appendRow([
      'N',
      'Фамилияси',
      'Исми',
      'Шарифи',
      'Тугилган санаси',
      'ПИНФЛ',
      'Гувохнома раками',
      'махалла',
      'Яшаш манзили'
    ]);

    // Write data to the worksheet
    List<PersonModel> personList = readAllData();
    for (var person in personList) {
      sheetObject.appendRow([
        count,
        person.surname,
        person.name,
        person.lastName,
        person.dateOfBirth,
        person.pinfl.replaceAll(" ", ''),
        person.metrka,
        person.mahalla,
        person.address
      ]);
      count++;
    }

    // Save the Excel file to a ByteData
    var excelData = excel.encode();

    // Save the ByteData to a file

    // final filePath = '/storage/emulated/0/Download/malumotlar.xlsx';
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentsDir.path}/malumotlar.xlsx';
    print(filePath);
    await File(filePath).writeAsBytes(excelData!);

    openFile(filePath);

    print('Excel file generated and saved successfully.');
  }

  Future<void> openFile(String filePath) async {
    if (await Permission.storage.request().isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(filePath);
      OpenFilex.open(filePath);
    }
  }
}
