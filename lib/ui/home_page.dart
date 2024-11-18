// import 'package:chat_app/config/app_constants.dart';
// import 'package:chat_app/helper/helper_functions.dart';
// import 'package:chat_app/service/auth_service.dart';
// import 'package:chat_app/service/database_service.dart';
// import 'package:chat_app/ui/login_screen.dart';
// import 'package:chat_app/ui/profile_page.dart';
// import 'package:chat_app/ui/search_page.dart';
// import 'package:chat_app/values/dimens.dart';
// import 'package:chat_app/widgets/group_tile.dart';
// import 'package:chat_app/widgets/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../values/colors.dart';
//
// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({super.key});
//
//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }
//
// class _HomePageScreenState extends State<HomePageScreen> {
//
//   String userName = "";
//   String email = "";
//   AuthService authService = AuthService();
//   Stream? groups;
//   bool _isLoading =  false;
//   String groupName = "";
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     gettingUserData();
//   }
//
//   //String manipulation
//   String getId(String res){
//     return res.substring(0, res.indexOf("_"));
//   }
//
//   String getName(String res){
//     return res.substring(res.indexOf("_")+1);
//
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   gettingUserData() async {
//     await HelperFunctions.getUserEmail().then((value) {
//       setState(() {
//         email = value!;
//       });
//     });
//
//     await HelperFunctions.getUserName().then((val) {
//
//       setState(() {
//
//         userName = val!;
//
//       });
//     });
//
//
//   //  getting the list of snapshots in out stream
//
//
//     await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
//
//       setState(() {
//         groups = snapshot;
//       });
//
//
//     });
//
//
//
//
//   }
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var width = AppConstants.width;
//     var height = AppConstants.height;
//
//    return Scaffold(
//      appBar: AppBar(
//        actions: [
//          IconButton(
//              onPressed: (){
//                nextScreenReplace(context, const SearchPage());
//              },
//              icon: const  Icon(Icons.search),
//          ),
//        ],
//        elevation: 0,
//        backgroundColor: Colors.orange.shade500,
//        centerTitle: true,
//        title: const Text(
//          'Groups',
//          style: TextStyle(
//              fontSize: 27,
//              fontWeight: FontWeight.bold,
//          ),
//        ),
//
//      ),
//      body: groupList(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          popUpDialog(context);
//        },
//        elevation: 0,
//        backgroundColor: Colors.deepOrangeAccent,
//        child:  const Icon(Icons.add,size: 30,color: Colors.white,),
//
//
//
//      ),
//      drawer: Drawer(
//        child: ListView(
//          padding: const EdgeInsets.symmetric(vertical: 50),
//          children: [
//            Icon(Icons.account_circle,
//              size: 150,
//              color: Colors.grey.shade700,
//            ),
//            const SizedBox(
//              height: 15,
//            ),
//            Text(userName,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 27,),),
//           const SizedBox(
//              height: 25,
//            ),
//            const Divider(
//              height: 2,
//              thickness: 1,
//              color: Colors.redAccent,
//            ),
//            ListTile(
//              onTap: (){},
//              selectedColor: Colors.deepOrange,
//              selected: true,
//              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//              leading: const Icon(Icons.group,),
//              title: const  Text('Groups',style: TextStyle(color: AppColors.black10),),
//            ),
//
//            // profile list tile
//            ListTile(
//              onTap: (){
//                nextScreenReplace(context, ProfilePageScreen(userName: userName, email: email,));
//              },
//
//              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//              leading: const Icon(Icons.person,),
//              title: const  Text('Profile',style: TextStyle(color: AppColors.black10),),
//            ),
//
//
//            //logout list tile
//            ListTile(
//              onTap: () async{
//                showDialog(
//                    context: context,
//                    builder: (context){
//                      return AlertDialog(
//                        title: const Text('Logout'),
//                        content: const Text('Are you sure you want to logout'),
//                        actions: [
//                          IconButton(
//                              onPressed: (){
//                                Navigator.pop(context);
//                              },
//                              icon: const Icon(Icons.cancel,color: Colors.red,)
//                          ),
//
//                          IconButton(
//                              onPressed: () async{
//                                await authService.signOut();
//                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=> const FirstScreen()), (route) => false);
//
//                              },
//                              icon: const Icon(Icons.done,color: Colors.green,)
//                          ),
//                        ],
//                      );
//                    }
//                );
//              },
//
//              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//              leading: const Icon(Icons.exit_to_app,),
//              title: const  Text('Logout',style: TextStyle(color: AppColors.black10),),
//            ),
//
//          ],
//        ),
//
//      ),
//    );
//   }
//
//
// //     create a popup dialog
//
//      popUpDialog(BuildContext context){
//       showDialog(
//           context: context,
//           builder: (context)
//           {
//             return StatefulBuilder(
//                 builder: (context,setState)
//                 {
//                   return AlertDialog(
//                     title: const Text('Create a group',textAlign: TextAlign.left,),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _isLoading == true ? const Center(
//                           child: CircularProgressIndicator(),
//                         ): TextField(
//                           onChanged: (val){
//                             groupName = val;
//                           },
//                           cursorColor: Colors.black,
//                           decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.orange),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.red),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.orange),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                           ),
//
//                         )
//                       ],
//                     ),
//                     actions: [
//                       ElevatedButton(
//                         onPressed: (){
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async{
//                           if(groupName!= "") {
//                             setState(() {
//                               _isLoading = true;
//                             });
//                             DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
//                                 .createGroup(
//                                 userName,
//                                 FirebaseAuth.instance.currentUser!.uid,
//                                 groupName)
//                                 .whenComplete(() {
//                               _isLoading = false;
//                             });
//                             Navigator.of(context).pop();
//                             const snackBar = SnackBar(
//                               backgroundColor: Colors.green,
//                               content: Text('Group Created Successfully',textAlign: TextAlign.center,),
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//                           }
//
//
//
//                         },
//                         child: const Text('Create'),
//                       ),
//                     ],
//                   ) ;
//                 }
//             ) ;
//           }
//       ) ;
//      }
//
//
// //  create a method
//      groupList(){
//
//     return StreamBuilder(
//       stream: groups,
//       builder: (context, AsyncSnapshot snapshot){
//       //   make some checks
//         if(snapshot.hasData){
//           if(snapshot.data['groups'] != null ){
//
//             if(snapshot.data['groups'].length != 0){
//               return ListView.builder(
//                 itemCount: snapshot.data['groups'].length,
//                 itemBuilder: (context,index){
//                   int reverseIndex = snapshot.data['groups'].length - index - 1;
//                   return GroupTile(
//                       userName: snapshot.data['fullName'],
//                       groupName: getName(snapshot.data['groups'][reverseIndex]),
//                       groupId: getId(snapshot.data['groups'][reverseIndex]),
//                   );
//
//
//                 }
//               );
//
//             }
//             else{
//
//               return noGroupWidget();
//
//             }
//
//
//
//
//           }
//           else{
//
//             return noGroupWidget();
//
//
//           }
//
//
//         }
//
//         else{
//
//           return const Center(
//             child: CircularProgressIndicator(color: Colors.deepOrange,),
//           );
//
//
//
//
//         }
//
//
//
//
//
//       },
//     );
//
//
//
//
//      }
//
//
//
//
// //     no group widget
//
//      noGroupWidget(){
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: (){
//               popUpDialog(context);
//             },
//               child: Icon(Icons.add_circle,size: 75,color: Colors.grey.shade700,)),
//            const SizedBox(
//              height: Dimens.dimens20,
//           ),
//           const Text(
//               "You've not joined any groups, tap on the add icon to create a group or also search from top search button",textAlign: TextAlign.center,
//           ),
//
//         ],
//       ),
//     );
//
//
//
//
//
//      }
//
//
// }

import 'package:chat_app/service/database_service.dart';
import 'package:chat_app/ui/login_screen.dart';
import 'package:chat_app/ui/profile_page.dart';
import 'package:chat_app/ui/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/helper_functions.dart';
import '../service/auth_service.dart';
import '../widgets/group_tile.dart';
import '../widgets/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserName().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50),
            children:[
              Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {},
                selectedColor: Colors.orange,
                selected: true,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Groups",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                  nextScreenReplace(
                      context,
                      ProfilePageScreen(
                        userName: userName,
                        email: email,
                      ));
                },
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const FirstScreen()),
                                        (route) => false);
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                      : TextField(
                    onChanged: (val) {
                      setState(() {
                        groupName = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DataBaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                          FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      // showSnackbar(
                      //     context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: getId(snapshot.data['groups'][reverseIndex]),
                      groupName: getName(snapshot.data['groups'][reverseIndex]),
                      userName: snapshot.data['fullName']);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
