import 'package:flutter/material.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/injection_container.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  
   final UserLocalDataSource userLocalDataSource=sl.get<UserLocalDataSource>();
   UserModelLogin? user=null;

   @override
  void initState()  {
    this.getUser();
    super.initState();
  }

  getUser()async{
    var res=await userLocalDataSource.getCachedUser();
    if(res!=null){
      setState(() {
          user= res;
      });
      print(user);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text( "Welcome",style: TextStyle(color: Colors.black),),
              elevation: 5,
              backgroundColor: Colors.white,
             ),
             body:   Padding(padding:const  EdgeInsets.all(15),
             child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                 Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                    SizedBox(height: 5),
                    Text(user?.nom.toString() ?? "default",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 2),
                    Text(user?.prenom.toString() ?? "default",style: TextStyle(fontSize: 15),)
                ]),),
                  SizedBox(height: 4),
                 Text(user?.email.toString() ?? "default",style: TextStyle(fontSize: 15),),
                 SizedBox(height: 200,),
              ],
            ),
          )
       );
   }
}


