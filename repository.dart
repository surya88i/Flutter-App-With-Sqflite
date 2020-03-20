import 'package:sqflite/sqflite.dart';
import 'package:upload_image/db_connection.dart';

class Repository
{
  DatabaseConnection connection;
  Repository(){
    connection=DatabaseConnection();
  }
  static Database _database;
  Future<Database> get database async{
    if(_database!=null){
      return _database;
    }
    _database=await connection.setDatabase();
    return _database;
  }
  save(table,data) async{
    var conn=await database;
    return await conn.insert(table, data);
  }
  getAll(table) async{
    var conn=await database;
    return await conn.query(table);
  }
  getById(String table,itemId) async{
    var conn=await database;
    return await conn.query(table,where: 'id=?',whereArgs: [itemId]);
  }
  update(String table,data) async{
    var conn=await database;
    return await conn.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }

  delete(String table, itemId) async {
    var conn=await database;
    return await conn.delete(table,where:'id=?',whereArgs: [itemId]);
    
  }
}