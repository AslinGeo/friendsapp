

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
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
  String? filterValue;
  List<String> filterItems=[
    'All',
    'SocialMedia Friend',
    'School Friend',
    'College Friend',
    'Best Friend',
    'Neighbor Friend',
    'Work Friend'
  ];
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
           TextButton(onPressed: (){},  child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.filter_alt,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: filterItems
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                  .toList(),
          value: filterValue,
          onChanged: (value) async{
            setState(() {
              filterValue = value as String;
             
            });
             if(filterValue=='All'){
                getAllData();
              }
              else{
                var data=await Service().readFilterData(filterValue);
                _friends=<Friends>[];
                _friends=data.map((value)=>Friends.fromJson(value)).toList();
              }
              setState(() {
                
              });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    ),
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