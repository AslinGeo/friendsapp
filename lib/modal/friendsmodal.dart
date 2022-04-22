class Friends{
  int? id;
  String? name;
  String? mobileno;
  String? category;
  String? dateofbirth;
  String? imagepath;

Friends({this.id,this.name,this.mobileno,this.category,this.dateofbirth,this.imagepath});

  friendsMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id;
    mapping['name']=name;
    mapping['mobileno']=mobileno;
    mapping['category']=category;
    mapping['dateofbirth']=dateofbirth;
    mapping['imagepath']=imagepath;
    return mapping;
  }
  factory Friends.fromJson(json){
    return Friends(
id:json['id'],
name: json['name'],
mobileno: json['mobileno'],
category: json['category'],
dateofbirth: json['dateofbirth'],
imagepath:json['imagepath']
    );
  }
}