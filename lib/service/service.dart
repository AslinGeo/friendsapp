import 'package:friends_app/database/repo.dart';
import 'package:friends_app/modal/friendsmodal.dart';

class Service{
  late Repo _repo;
  Service(){
    _repo=Repo();
  }

  saveData(Friends friends) async{
  //  print(todo);
   return await _repo.insertData('friends', friends.friendsMap());

 }
 readAllData() async{
   return await _repo.readData('friends');

 }
 UpdateFriend(Friends friends) async{
    return await _repo.updateData('friends', friends.friendsMap());
  }

}

