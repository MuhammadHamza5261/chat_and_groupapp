import 'package:chat_app/config/app_constants.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/ui/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/images.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/routes.dart';
import 'home_page.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var width = AppConstants.width;
  var height = AppConstants.height;


  //text editing controller
  final nameController =  TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool obscure = true;

  // String fullName =.text;
  // String email = "";
  // String password = "";

  AuthService authService = AuthService();

  final formKey = GlobalKey<FormState>();




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
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  Text('Groupie',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: AppColors.black10,
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens5,
                  ),
                  Text('Create your account now to chat and explore',
                    style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(
                    height: Dimens.dimens10,
                  ),
                  Image.asset(Images.loginImage,width: 250,),

                  const SizedBox(
                    height: Dimens.dimens20,
                  ),

                  //name text field
                  SizedBox(
                    height: 75,
                    child: CustomTextField(
                      prefixIcon: const Icon(Icons.person,color: Colors.black,),
                      validation: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onTap: () {},
                      isActive: true,
                      controller: nameController,
                      labelText: 'Full Name',
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dimens12,
                  ),

                  //email text field
                  SizedBox(
                    height: 75,
                    child: CustomTextField(
                      prefixIcon: const Icon(
                        Icons.email,color: Colors.black,
                      ),
                      validation: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add more specific email validation logicif needed
                        else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
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
                      prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                      validation: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        else if(!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
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
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
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
