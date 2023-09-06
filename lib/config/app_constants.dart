import 'package:flutter/cupertino.dart';
import 'navigation_key.dart';

class AppConstants{

   static var appContext = NavigationKey.navigationKey.currentContext!;

   static var width = MediaQuery.of(appContext).size.width;
   static var height = MediaQuery.of(appContext).size.height;


//  to add firebase credentials
 static String appId = "1:1090306191917:web:99c2e01981db6974fffea4";
 static String appKey = "AIzaSyCBbbTK7D9WWoZ0BgGdwRIUnsCugFzXKy8";
 static String messagingSenderId = "1090306191917";
 static String projectId = "chatappflutter-8aa40";

}