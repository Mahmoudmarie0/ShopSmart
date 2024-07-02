import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController{
static const THEME_STATUS = "THEME_STATUS";
bool _darkTheme = false;
bool get getIsDarkTheme => _darkTheme;

MainController(){
  //to save the theme value
  getTheme();
}


Future<void>setDarkTheme({required bool themeValue})async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(THEME_STATUS, themeValue);
  _darkTheme = themeValue;
  update();
}

Future<bool>getTheme()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _darkTheme = prefs.getBool(THEME_STATUS)??false;
  update();
  return _darkTheme;
}

}