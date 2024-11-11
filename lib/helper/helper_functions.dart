import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  //  keys

  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";


  // saving the data in of user logged in

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async{

    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);

  }

  // saving the data in user name key

  static Future<bool> saveUserNameSF(String userName) async{

    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);

  }

//  saving the data in email key


  static Future<bool> saveUserEmailSF(String userEmail) async{

    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);

  }


//    getting the data from sf
static Future<bool?> getUserLoggedInStatus() async {

  SharedPreferences sf = await SharedPreferences.getInstance();

  return sf.getBool(userLoggedInKey);

}


//  getting user email

  static Future<String?> getUserEmail() async {

    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getString(userEmailKey);

  }


  //get user name


  static Future<String?> getUserName() async {

    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getString(userNameKey);

  }

}