import 'package:shared_preferences/shared_preferences.dart';
import 'app_function.dart';

class AppConstant {
  static SharedPreferences? sharedPreferences;
  static int isViewd = 0;
}

const String baseurl = "newsapi.org";
const String apiKey = "1549f7110b844fae9d5cf4240e3f4be6";
AppFunction globalMethod = AppFunction();

final List<String> categories = [
  'General',
  'Technology',
  'Sports',
  'Science',
  'Business',
  'Entertainment',
  'Health'
];
