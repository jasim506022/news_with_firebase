import 'package:shared_preferences/shared_preferences.dart';
import 'app_function.dart';

class AppConstants {
  static SharedPreferences? sharedPreferences;
  static bool isOnboardingViewed = false;

  // bool isSet = true;

  static int categoryLength = 7;
  static String baseurl = "newsapi.org";

  static List<String> categories = [
    'General',
    'Technology',
    'Sports',
    'Science',
    'Business',
    'Entertainment',
    'Health'
  ];
}

const String apiKey = "1549f7110b844fae9d5cf4240e3f4be6";
AppFunction globalMethod = AppFunction();
