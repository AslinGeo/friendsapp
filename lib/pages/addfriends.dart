
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friends_app/modal/friendsmodal.dart';
import 'package:friends_app/pages/homepage.dart';
import 'package:friends_app/service/service.dart';
import 'package:image_picker/image_picker.dart';

class AddFriends extends StatefulWidget {
  AddFriends({Key? key,  this.data}) : super(key: key);
  
  final Friends?data;
  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final _namecontroller = TextEditingController();
  final _mobilenocontroller = TextEditingController();
  final _categorycontroller = TextEditingController();
  final _datecontroller = TextEditingController();
  bool _validateName = false;
  bool _validateMobileno = false;
  bool _validateCategory = false;
  bool _validateDate = false;
  final ImagePicker _picker = ImagePicker();
  dynamic imagePath = "";

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  var dropDownValue = [
    'SocialMedia Friend',
    'School Friend',
    'College Friend',
    'Best Friend',
    'Neighbor Friend',
    'Work Friend'
  ];
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
    _namecontroller.text=widget.data?.name ?? '';
    _mobilenocontroller.text=widget.data?.mobileno ?? '';
    _categorycontroller.text=widget.data?.category ?? '';
    _datecontroller.text=widget.data?.dateofbirth ?? '';
    imagePath=widget.data?.imagepath ??'';
    });
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: widget.data == null ? const Text("Add Friend") :const Text("Edit Friend"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter Name',
                labelText: 'Name',
                errorText: _validateName ? 'Please Enter Name' : null,
                icon:const  Icon(Icons.contact_mail)
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mobilenocontroller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter MobileNo',
                labelText: 'Mobile No',
                counterText: '',
                errorText: _validateMobileno ? 'Please Enter MobileNo' : null,
                icon:const  Icon(Icons.phone_android)
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              maxLength: 10,
            ),
            const SizedBox(height: 20),
            PopupMenuButton<String>(
              child: Stack(
                children: [
                  TextField(
                    controller: _categorycontroller,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Category',
                      labelText: 'Category',
                      errorText:
                          _validateCategory ? 'Please Enter Category' : null,
                          icon: const Icon(Icons.category_rounded)
                    ),
                  ),
                  const Positioned(
                      top: 13, right: 30, child: Icon(Icons.arrow_drop_down))
                ],
              ),
              // icon: const Icon(Icons.arrow_drop_down),

              onSelected: (String value) {
                _categorycontroller.text = value;
              },

              itemBuilder: (BuildContext context) {
                return dropDownValue.map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem(child: Text(value), value: value);
                }).toList();
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _datecontroller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter Birth Date',
                labelText: 'Birth Date',
                errorText: _validateDate ? 'Please Enter Date' : null,
                icon: const Icon(Icons.date_range_rounded,),
                
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);

                FocusScope.of(context).requestFocus(FocusNode());

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1920),
                    lastDate: DateTime.now());
                _datecontroller.text = date !=null?date.toIso8601String().replaceAll("T00:00:00.000", ""):_datecontroller.text;
              },
            ),
           const SizedBox(height: 20,),
            Row(
              children: [
               const  Icon(Icons.image),
               const SizedBox(width: 17,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black12)
                      ),
                   color: Colors.white,
                   padding: const EdgeInsets.all(20),
                  onPressed: () async {
                    imagePath = "";
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        imagePath = image.path;
                      });
                    }
                  },
                  child: SizedBox(
                   
                    width: 303.0,
                    child:  
                     Row(
           children: [
            const  Text('Upload Image'),
            const SizedBox(width: 150,),
              imagePath !="" && imagePath!=null ? 
             CircleAvatar( backgroundImage:FileImage(File(imagePath ??'',),),
            //  radius: 80,
             
            ):Container()
           ],
         ),
                  ),
                ),
              ],
            ),    
          const  SizedBox(height: 40,),
        
                
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
                  
                backgroundColor: Colors.pinkAccent,
                  onPressed: () async {
                    setState(() {
                      _validateName =
                          _namecontroller.text.isEmpty ? true : false;
                      _validateMobileno =
                          _mobilenocontroller.text.isEmpty ? true : false;
                      _validateCategory =
                          _categorycontroller.text.isEmpty ? true : false;
                      _validateDate =
                          _datecontroller.text.isEmpty ? true : false;
                    });

                    if (_validateName == false &&
                        _validateMobileno == false &&
                        _validateCategory == false &&
                        _validateDate == false) {
                      var _friends = Friends();
                      _friends.name = _namecontroller.text;
                      _friends.mobileno = _mobilenocontroller.text;
                      _friends.category = _categorycontroller.text;
                      _friends.dateofbirth = _datecontroller.text;
                      _friends.imagepath = imagePath.toString();
                      if(widget.data==null){
                         var result = await Service().saveData(_friends);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => 
             const HomeScreen(),)
             );
                      _showSuccessSnackBar('Your Data Saved');
                      }
                      else{
                        _friends.id=widget.data?.id;
                        var result= await Service().UpdateFriend(_friends);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => 
             const HomeScreen(),)
             );
                        _showSuccessSnackBar('Your Data Updated');
                      }
                     
                    }
                  },
                  child:widget.data ==null ? const Icon(Icons.save): const Icon(Icons.update)
                  ),
      
    );
  }
}
