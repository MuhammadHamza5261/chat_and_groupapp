import 'package:chat_app/config/app_constants.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/ui/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field_two.dart';
import '../widgets/routes.dart';
import 'home_page.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController =  TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool obscure = true;


  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() async{

    setState(() {
      _isLoading = true;
    });

    await authService.registerUserWithEmailAndPassword(
      nameController.text,
      emailController.text,
      passwordController.text,).then((value) async {

        if(value == true){
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailController.text);
          await HelperFunctions.saveUserNameSF(nameController.text);
          nextScreen(context, const HomePage());
          
        }

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const  HomePage()),
        );
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
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Dimens.dimens30,
                  ),

                  const SizedBox(
                    height: Dimens.dimens25,
                  ),
                  Image.asset(Images.loginImage,width: 200,),
                  const SizedBox(
                    height: Dimens.dimens25,
                  ),
                  Text('Welcome!!',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColor.black10,
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens20,
                  ),
                  Text('Create your account now to chat and explore',
                    style: Theme.of(context).textTheme.titleSmall,),

                  const SizedBox(
                    height: Dimens.dimens30,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CustomInputFieldTwo(

                      hintText: 'User Name',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColor.black10
                      ),
                      controller: nameController,
                      prefixIcon: Icons.person,
                      validator: (String? text) {
                        if (text!.isEmpty) {
                          return 'Enter user name';
                        }

                        return null;
                      },
                    ),
                  ),


                  const SizedBox(
                    height: Dimens.dimens12,
                  ),
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
                    height: Dimens.dimens20,
                  ),
                  // SizedBox(
                  //   width: width*0.9,
                  //   height: height*0.065,
                  //   child:  ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: Colors.deepOrange,
                  //       ),
                  //       onPressed: (){
                  //         if(formKey.currentState!.validate())
                  //         {
                  //           _submitForm();
                  //         }
                  //       },
                  //       child: const Text(
                  //         'Register',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //   ),
                  // ),
                  // row
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
                          if (_formKey.currentState!.validate()) {
                            _submitForm();

                          }
                        },
                        child: Center(
                          child:  Text(
                            'Submit',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: ('Don\'t have an account?'),
                      children:[

                        TextSpan(text:'Login',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              nextScreen(context,const FirstScreen());
                            },
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
