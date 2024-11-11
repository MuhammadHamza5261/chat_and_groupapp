import 'package:chat_app/main.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:chat_app/ui/home_page.dart';
import 'package:chat_app/ui/register_screen.dart';
import 'package:chat_app/values/dimens.dart';
import 'package:chat_app/values/images.dart';
import 'package:chat_app/widgets/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../helper/helper_functions.dart';
import '../service/auth_service.dart';
import '../styles/app_colors.dart';
import '../values/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field_two.dart';



class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;
  AuthService authService = AuthService();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;




  void _submitForm() async{

    setState(() {
       _isLoading = true;
    });

    await authService.loginUserWithEmailAndPassword(
      emailController.text,
      passwordController.text).then((value) async {

      if(value == true){

       QuerySnapshot snapshot =  await DataBaseService(
           uid: FirebaseAuth.instance.currentUser!.uid).getUserData(
          emailController.text,

        );

        //saving the values to our shared preferences

       await HelperFunctions.saveUserLoggedInStatus(true);
       await HelperFunctions.saveUserEmailSF(emailController.text);
       await HelperFunctions.saveUserNameSF(
         snapshot.docs[0]['fullName'],
       );

        nextScreen(context,  HomePage());

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              'Invalid email or password',
              textAlign: TextAlign.center,
            ),
            ),

        );}

    
      setState(() {
        _isLoading = false;
      });
    }).onError((e, stackTrace){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
          'Invalid email or password',
          textAlign: TextAlign.center,
        ),
          backgroundColor: AppColor.red10,
        ),
      );
    }) ;
  }


  @override
  Widget build(BuildContext context) {
    var width = AppConstants.width;
    var height = AppConstants.height;
    return Scaffold(
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  Image.asset(Images.loginImage,width: 200,),
                  SizedBox(
                    height: Dimens.dimens25,
                  ),
                  Text('Welcome Back!!',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColor.black10,
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens20,
                  ),
                  Text('If you are already register!! please login',
                    style: Theme.of(context).textTheme.titleSmall,),

                  const SizedBox(
                    height: Dimens.dimens30,
                  ),

                  //email text field
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CustomInputFieldTwo(

                      hintText: 'Email',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColor.black10
                      ),
                      controller: emailController,
                      prefixIcon: Icons.email,
                      validator: (String? text) {
                        if (text!.isEmpty) {
                          return 'Enter email';
                        }
                        else if(!text.contains('@')){
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens12,
                  ),

                //  password text field

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CustomInputFieldTwo(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,

                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColor.black10
                      ),
                      controller: passwordController,
                      prefixIcon: Icons.lock,
                      validator: (String? text) {
                        if (text!.isEmpty) {
                          return 'Enter password';
                        }


                        return null;
                      },
                    ),
                  ),

                  // btn
                  const SizedBox(
                    height: Dimens.dimens40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SizedBox(
                      width: width,
                      child: CustomButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        buttonColor: Colors.deepOrange,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _submitForm();

                          }
                        },
                        child: Center(
                          child:  Text(
                            'Login',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // row
                  const SizedBox(
                    height: Dimens.dimens20,
                  ),
                    Text.rich(
                     TextSpan(
                       text: ('Don\'t have an account?'),
                       children: <TextSpan>[
                         TextSpan(text: 'Register here',
                             style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                           recognizer: TapGestureRecognizer()..onTap = (){
                             nextScreen(context,const RegisterScreen());
                         }
                         ),
                       ],
                     ),


                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
