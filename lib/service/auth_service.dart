import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //  firstly we create a login method

  Future loginUserWithEmailAndPassword(String email, String password) async{

    try
    {
      User user = (await  firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password,
      )).user!;


      if(user!= null){

        return true;

      }

    } on FirebaseAuthException



    catch(e){
      return e.message;

    }

  }




  // register method

  Future registerUserWithEmailAndPassword(String fullName, String email, String password) async{

  try
  {
     User user = (await  firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    )).user!;


     if(user!= null){

      await DataBaseService(uid: user.uid).savingUserData(fullName, email);
        return true;

     }

  } on FirebaseAuthException



  catch(e){
    return e.message;

  }

}


// logout method


Future signOut() async{

    try{

      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();

    }

    catch(e){

    }

}


}