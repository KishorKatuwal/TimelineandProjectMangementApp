import 'package:shared_preferences/shared_preferences.dart';

class CallingMethod{

  Future<bool> hasMethodExecuted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('methodExecuted') ?? false;
  }

  Future<void> markMethodAsExecuted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('methodExecuted', true);
  }


  Future<void> runMethodOnce() async {
    bool methodExecuted = await hasMethodExecuted();
    if (!methodExecuted) {
        print("method run once");
      await markMethodAsExecuted();
    }else{
      print("Method run on else");
    }
  }



}