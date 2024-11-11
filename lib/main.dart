import 'package:chat_app/config/app_constants.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/ui/login_screen.dart';
import 'package:chat_app/ui/home_page.dart';
import 'package:chat_app/ui/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/navigation_key.dart';


void main() async {
  //add firebase
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: AppConstants.appKey,
        appId: AppConstants.appId,
        messagingSenderId: AppConstants.messagingSenderId,
        projectId: AppConstants.projectId,
      ),
    );
  }
  else{
    await Firebase.initializeApp();

  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }


  getUserLoggedInStatus() async{

    await HelperFunctions.getUserLoggedInStatus().then((value) {

      if(value !=  null){
        isSignedIn = value;

      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationKey.navigationKey,

      home: isSignedIn ? const HomePage() : const RegisterScreen(),
      // home: HomePageScreen(),
    );
  }
}
