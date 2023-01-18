import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({Key? key}) : super(key: key);

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  String formattedDate = DateFormat('E').format(DateTime.now()).toUpperCase();


  List<List<dynamic>> _data = [];
  List<List<dynamic>> classT = [];
  int count = 0;

  bool loading = false;
  String dropdownvalue = 'C4';

  // List of items in our dropdown menu
  var items = [
    'C1',
    'C2',
    'C3',
    'C4',
    'C5',
    'C6',
    'C7',
    'C8',
    'C9',
    'C10',
    'C11',
    'C12',
    'C13',
    'C14',
    'C15',
  ];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/data.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    _data = _listData;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCSV();
    print("reached here");
    // print("Today is " + formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Islington Routine"),
        centerTitle: true,
      ),
      // Display the contents from the CSV file
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Select your Group:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                // Initial Value
                value: dropdownvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    // print(dropdownvalue);
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index) {
                if (dropdownvalue == "C1" ||
                    dropdownvalue == "C2" ||
                    dropdownvalue == "C3" ||
                    dropdownvalue == "C4" ||
                    dropdownvalue == "C5" ||
                    dropdownvalue == "C6" ||
                    dropdownvalue == "C7" ||
                    dropdownvalue == "C8" ||
                    dropdownvalue == "C9" ||
                    dropdownvalue == "C10") {
                  if (_data[index][6] == dropdownvalue ||
                      _data[index][6] == "C1-C10") {
                    // if (_data[index][0] == formattedDate) {
                      print("The current index is $index");
                      print(_data[index][0]);
                      count = count + 1;
                      print("Count value is K $count");

                      classT.add(
                          [_data[index][0], _data[index][1], _data[index][6]]);
                      print(classT);

                      return Card(
                        margin: const EdgeInsets.all(3),
                        color: index == 0 ? Colors.amber : Colors.white,
                        child: ListTile(
                          leading: Text(classT[count - 1][0]),
                          title: Text(classT[count - 1][1]),
                          trailing: Text(classT[count - 1][2]),
                        ),
                      );
                    // } else {
                    //   return Container();
                    //   // else if (_data[index][0] != formattedDate &&
                    //   //     _data[index][6] == dropdownvalue) {
                    //   //   // count = 0;
                    //   //   print("Count value is K $count");
                    //   //   return Container();
                    // }
                  } else {
                    return Container();
                  }
                }  else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
