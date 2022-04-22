
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friends_app/modal/friendsmodal.dart';
import 'package:friends_app/pages/addfriends.dart';


class View extends StatelessWidget {
   View({ Key? key,required this.data, }) : super(key: key);
 
final Friends? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Details"),
        
         backgroundColor: Colors.pink.shade400,
          actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
             AddFriends(data: data,),)
             );
          }, 
          child:const Icon(Icons.edit_rounded,color: Colors.white,))
        ]
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
         data?.imagepath !=null && data?.imagepath !="" ? 
             CircleAvatar( backgroundImage:FileImage(File(data?.imagepath ??'',),),
             radius: 80,
             
            ):CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: const Icon(Icons.person,color: Colors.grey,size: 100,),
              radius: 80,
            ),
        const SizedBox(height: 20,),
          Card(
            child:Column(
              children: [
                 const SizedBox(height: 20,), 
                 Row(
                 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    
                     Text(data?.name ?? '',
                     style:const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                  ],
                ),
             const SizedBox(height: 10,),         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Icon(Icons.phone),
            const  SizedBox(width: 10,),
              Text(data?.mobileno ?? '',
              style: const TextStyle(fontSize: 25,fontWeight: FontWeight.normal))
            ],
          ),
           const SizedBox(height: 30,), 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 8, 152, 82),
                 child:Icon(Icons.call,color: Colors.white,),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 8, 152, 82),
                 child: Icon(Icons.message_outlined,color: Colors.white,),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 8, 152, 82),
                 child: Icon(Icons.mail_outline,color: Colors.white,),
                ),
              ],
            ),
             const SizedBox(height: 30,), 
              ],
            ),
          ),
         const SizedBox(height: 20,),
         ListTile(
          trailing: const Icon(Icons.category),
          title: Text(data?.category ?? ''),
         ),
        const Divider(height: 3,),
          ListTile(
          trailing: const Icon(Icons.date_range),
          title: Text(data?.dateofbirth ?? ''),
         ),
        const Divider(height: 3,),
        ],
      ),
      
    );
  }
}