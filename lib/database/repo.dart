import 'package:friends_app/database/dbconnection.dart';
import 'package:sqflite/sqflite.dart';



class Repo{
   late DatabaseConnection _databaseConnection;
  Repo(){
    _databaseConnection=DatabaseConnection();
  }
  static Database? _database;

Future<Database?>get database async {
			if (_database != null) {
				return _database;
			} else {
				_database = await _databaseConnection.setDatabase();
				return _database;
			}
		}


insertData(table,data) async{

  var connection= await database;
  return await connection?.rawInsert(
     
      'INSERT INTO friends(name, mobileno, category,dateofbirth,imagepath) VALUES("${data['name']}", "${data['mobileno']}", "${data['category']}", "${data['dateofbirth']}","${data['imagepath']}")');
  

}

readData(table) async{
  var connection= await database;
  return await connection?.query(table);
}

updateData(table, data) async {
	var connection = await database;
	return await connection
	?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
}
readFilterData(data) async{
  var connection=await database;
  return await connection?.query('friends', where: '"category" = ?', whereArgs: [data]);

}
}