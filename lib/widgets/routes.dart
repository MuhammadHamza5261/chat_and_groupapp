
import 'package:flutter/material.dart';


//now we can create a routes

void nextScreen(context,page){
  
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));

}

void nextScreenReplace(BuildContext context,Widget page){

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  page));

}