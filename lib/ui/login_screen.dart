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
import '../values/colors.dart';
import '../widgets/custom_text_field.dart';


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
          backgroundColor: AppColors.red10,
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
                  Text('Groupie',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.black10),),
                  const SizedBox(
                    height: Dimens.dimens5,
                  ),
                  Text('Login now to see what they are talking',style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(
                    height: Dimens.dimens10,
                  ),
                  Image.asset(Images.loginImage,width: 250,),
                 const SizedBox(
                    height: Dimens.dimens20,
                  ),

                  //email text field
                  SizedBox(
                    child: CustomTextField(
                      prefixIcon: Icon(Icons.email,color: Colors.black,),
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add more specific email validation logicif needed
                        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onTap: () {},
                      isActive: true,
                      controller: emailController,
                      labelText: 'Email or phone number',
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens12,
                  ),

                //  password text field

                  SizedBox(
                    height: 75,
                    child: CustomTextField(
                      prefixIcon: Icon(Icons.lock,color: Colors.black,),

                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
                          return 'Only letters and digits are allowed';
                        }

                        // You can add more specific email validation logic if needed
                        return null;
                      },

                      onTap: () {},
                      isActive: true,
                      obscureText: obscure,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: Text(obscure ? "Show" : "Hide"),
                      ),
                      controller: passwordController,
                      labelText: 'Password',
                    ),
                  ),

                  // btn
                  const SizedBox(
                    height: Dimens.dimens40,
                  ),
                  SizedBox(
                    width: width*0.9,
                    height: height*0.065,
                    child:  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                      ),
                        onPressed: (){
                          if(formKey.currentState!.validate())
                          {
                            _submitForm();
                          }

                        },
                        child: const  Text('Login',style: TextStyle(fontSize: 18),)
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
