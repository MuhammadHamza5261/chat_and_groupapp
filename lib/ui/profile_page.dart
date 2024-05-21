import 'package:chat_app/config/app_constants.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import '../values/colors.dart';
import '../widgets/routes.dart';
import 'login_screen.dart';

class ProfilePageScreen extends StatefulWidget {
  String userName;
  String email;
   ProfilePageScreen({super.key,required this.userName, required this.email});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {


  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {

    var width = AppConstants.width;
    var height = AppConstants.height;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade500,
        centerTitle: true,
        title: const Text('Profile Screen',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Icon(Icons.account_circle,size: 200,color: Colors.grey.shade700,),
           const SizedBox(
             height: 15,
           ),
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               const Text('Full Name',style: TextStyle(fontSize: 20,),),
               Text(widget.userName,style: const TextStyle(fontSize: 20,),),
             ],
           ),
          const Divider(
            height: 20,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               const Text('Email',style: TextStyle(fontSize: 20,),),
               Text(widget.email,style: const TextStyle(fontSize: 20,),),
             ],
           ),


         ],
       ),
      ),


      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(Icons.account_circle,size: 150,color: Colors.grey.shade700,),
            const SizedBox(
              height: 15,
            ),
          Text(widget.userName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              height: 2,
              thickness: 1,
              color: Colors.redAccent,
            ),
            ListTile(
              onTap: (){
                nextScreen(context, const HomePage());

              },
              selectedColor: Colors.deepOrange,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.group,),
              title: const  Text('Groups',style: TextStyle(color: AppColors.black10),),
            ),

            // profile list tile
            ListTile(
              onTap: (){
                // nextScreenReplace(context, ProfilePageScreen());
              },

              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.person,),
              title: const  Text('Profile',style: TextStyle(color: AppColors.black10),),
            ),


            //logout list tile

            ListTile(
              onTap: () async{
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout'),
                        actions: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel,color: Colors.red,)
                          ),

                          IconButton(
                              onPressed: () async{
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=> const FirstScreen()), (route) => false);

                              },
                              icon: const Icon(Icons.done,color: Colors.green,)
                          ),
                        ],
                      );
                    }
                );
              },

              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.exit_to_app,),
              title: const  Text('Logout',style: TextStyle(color: AppColors.black10),),
            ),

          ],
        ),

      ),
    );
  }
}
