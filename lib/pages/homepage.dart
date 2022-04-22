

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friends_app/modal/friendsmodal.dart';
import 'package:friends_app/pages/addfriends.dart';
import 'package:friends_app/pages/view.dart';
import 'package:friends_app/service/service.dart';




class HomeScreen extends StatefulWidget {
 const  HomeScreen({ Key? key, }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Widget appBarTitle = const  Text("Friends App");
  Icon actionIcon =  const Icon(Icons.search);
  @override
  initState(){
    getAllData();
  }


 List _friends=[];
 getAllData() async{
   var data= await Service().readAllData();
   _friends=<Friends>[];
_friends = data.map((value)=>Friends.fromJson(value)).toList();
setState(() {
  
});
  
 }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade400,
        leading: const Icon(Icons.person),
        title: appBarTitle,
          actions: <Widget>[
             IconButton(icon: actionIcon,onPressed:(){
              setState(() {
                if ( actionIcon.icon == Icons.search){
                  actionIcon =  const Icon(Icons.close);
                  appBarTitle =  const TextField(
                    style:  TextStyle(
                      color: Colors.white,

                    ),
                    decoration:   InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white)
                    ),
                  );}
                else {
                  actionIcon = const Icon(Icons.search);
                  appBarTitle = const Text("Friends App");
                }


              });
            } ,),
            
            ]
      
        ),
        
  
      body:_friends.length!=0 ?  ListView.builder(
       itemCount: _friends.length,
        itemBuilder: (context,index){
         return Card(
           child: ListTile(
             
             leading:_friends[index].imagepath !=null && _friends[index].imagepath !="" ? 
             CircleAvatar(backgroundImage: FileImage(File(_friends[index].imagepath )),
             
            ):CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: const Icon(Icons.person,color: Colors.grey,),
            ),
             title:  Text(_friends[index].name ?? '',
                  style:const TextStyle(color:Colors.pinkAccent ,fontWeight: FontWeight.bold),),
              subtitle: Text(_friends[index].category ?? '',
                  style:const TextStyle(color:Colors.pinkAccent )),
                  onTap: (){
                 
                   var data=_friends[index];
                      Navigator.push(
                           context,
                        MaterialPageRoute(builder: (context) =>  View( data:data,)),
                         );
                  },  
           ),
         );
        },
        ):
        Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: const [
             Icon(Icons.person,color: Colors.grey,size: 100,),
             Text('No   Data',style: TextStyle(color: Colors.black),)
          ],

      ),
        ),
     
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => 
             AddFriends(),)
             );
        },
        child: const Icon(Icons.add),),
    );
  }
}