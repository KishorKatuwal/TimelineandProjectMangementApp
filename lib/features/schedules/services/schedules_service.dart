import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/Provider.dart';
import '../../../providers/user_provider.dart';

class SchedulesService {
  Future<List<List>> loadListFromCSV(String WeekDay, String Group) async {
    List<List<dynamic>> _data = [];
    List<List<dynamic>> _finaldata = [];
    String data = await rootBundle.loadString("assets/data.csv");
    List<List<dynamic>> rows = const CsvToListConverter().convert(data);
    _data = rows;
    for (int i = 0; i < _data.length; i++) {
      if (_data[i][6] == Group && _data[i][0] == WeekDay) {
        _finaldata.add([
          _data[i][0],
          _data[i][1],
          _data[i][2],
          _data[i][3],
          _data[i][4],
          _data[i][5],
          _data[i][6],
          _data[i][7],
          _data[i][8]
        ]);
      }
    }
    return _finaldata;
  }

  Future<List<List>> forNotification(BuildContext context) async {
    final group =  Provider.of<UserProvider>(context,listen: false).user.group;
    List<List<dynamic>> _data = [];
    List<List<dynamic>> _finaldata = [];
    String data = await rootBundle.loadString("assets/data.csv");
    List<List<dynamic>> rows = const CsvToListConverter().convert(data);
    _data = rows;
    for (int i = 0; i < _data.length; i++) {
      if (_data[i][6] == group) {
        _finaldata.add([
          _data[i][0],
          _data[i][1],
          _data[i][2],
          _data[i][3],
          _data[i][4],
          _data[i][5],
          _data[i][6],
          _data[i][7],
          _data[i][8],
          _data[i][9],
          _data[i][10],
          _data[i][11]
        ]);
      }
    }
    return _finaldata;
  }
}
