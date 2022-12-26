import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:path/path.dart';

import 'note.dart';


class NotesDataBase{

  static final NotesDataBase instance=NotesDataBase._init();
  static Database ?_database;
  NotesDataBase._init();
  Future<Database> get database async {
   if(_database !=null) return _database!;
   _database =await _initDB('notes.db');
   return _database!;

  }


  Future<Database> _initDB(String filePath) async {
   final dbPath =await getDatabasesPath();
   final path =join( dbPath, filePath);
   return await openDatabase(path, version: 1, onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final textType = 'TEXT NOT NULL';
    final textType = 'TEXT';
    // final boolType = 'BOOLEAN NOT NULL';
    // final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableNotes(
      ${CartNoteFields.id} $idType,
      ${CartNoteFields.productId} $textType,
      ${CartNoteFields.productName} $textType,
      ${CartNoteFields.productRegularPrice} $textType,
      ${CartNoteFields.productDiscountedPrice} $textType,
      ${CartNoteFields.productPhoto} $textType,
      ${CartNoteFields.productQuantity} $textType,
      
      
      ${CartNoteFields.weight} $textType,
      ${CartNoteFields.seller} $textType,
      ${CartNoteFields.sellerName} $textType,
      ${CartNoteFields.slug} $textType,
      ${CartNoteFields.colorImage} $textType,
      ${CartNoteFields.size} $textType,
      ${CartNoteFields.color} $textType,
      ${CartNoteFields.sizeId} $textType,
      ${CartNoteFields.colorId} $textType,
      ${CartNoteFields.grocery} $textType,
      
      ${CartNoteFields.tax} $textType,
      ${CartNoteFields.shipping} $textType,
      ${CartNoteFields.width} $textType,
      ${CartNoteFields.height} $textType,
      ${CartNoteFields.depth} $textType,
      ${CartNoteFields.weightOption} $textType,
      ${CartNoteFields.commission} $textType,
      ${CartNoteFields.commissionType} $textType
      )
      '''
    );
  }


  Future<CartNote> create(CartNote note) async{
    final db = await instance.database;
   // _showToast("call");
    // final json =note.toJson();
    // final columns ='${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values ='${json[NoteFields.title]}, ${json[NoteFields.description]},'
    //     ' ${json[NoteFields.time]}';
    //
    // final id =await db.rawInsert( 'INSERT INTO table_name ($columns) VALUES ($values)');


    final id=await db.insert(tableNotes, note.toJson());

    _showToast("Cart Added Successfully");

    return note.copy(id:id);
  }

  Future<CartNote> readNote(int id) async {
    final db =await instance.database;

    final maps =await db.query(
      tableNotes,
      columns: CartNoteFields.values,
      where: '${CartNoteFields.id}= ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return CartNote.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }

  }


  // Future<List<CartNote>> readAllNotes1() async{
  //   final db =await instance.database;
  //
  //   final orderBy='${CartNoteFields.time} ASC';
  //   /// final result =await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
  //
  //   final result =await db.query(tableNotes,orderBy: orderBy);
  //
  //   return result.map((json) => Note.fromJson(json)).toList();
  //
  // }
  Future<List<CartNote>> readAllNotes() async{
    final db =await instance.database;

    // final orderBy='${NoteFields.time} ASC';
    /// final result =await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result =await db.query(tableNotes);

    return result.map((json) => CartNote.fromJson(json)).toList();

  }

  Future<int> update (CartNote note)async{
    final db =await instance.database;
    return db.update(
        tableNotes,
        note.toJson(),
        where: '${CartNoteFields.id}=?',
      whereArgs: [note.id],
    );

  }

  Future<int> delete(int id)async{
    final db =await instance.database;
    return await db.delete(
        tableNotes,
      where: '${CartNoteFields.id}=?',
      whereArgs: [id],
    );

  }


  Future close() async{
  final db = await instance.database;
  db.close();
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

 }