import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/Provider.dart';
import '../../../providers/user_provider.dart';

class ExamServices {
  Future<List<List>> loadListFromCSV(BuildContext context) async {
    final year =  Provider.of<UserProvider>(context,listen: false).user.year;
    final faculty =  Provider.of<UserProvider>(context,listen: false).user.faculty;
    List<List<dynamic>> _data = [];
    List<List<dynamic>> _finaldata = [];
    String data = await rootBundle.loadString("assets/exam.csv");
    List<List<dynamic>> rows = const CsvToListConverter().convert(data);
    _data = rows;
    for (int i = 0; i < _data.length; i++) {
      if (_data[i][2] == year && _data[i][3] == faculty) {
        _finaldata.add([
          _data[i][0],
          _data[i][1],
          _data[i][2],
          _data[i][3],
          _data[i][4],
          _data[i][5],
          _data[i][6],
          _data[i][7],
        ]);
      }
    }
    return _finaldata;
  }
}
