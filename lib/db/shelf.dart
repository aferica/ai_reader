import 'package:sqflite/sqflite.dart';
//import 'package:sqflite/sql.dart';

import 'db.dart';

final String tableShelf = 'shelf';
final String columnId = '_id';
// 书名
final String columnName = 'name';
// 作者
final String columnAuthor = 'author';
// 封面
final String columnCover = 'cover';
// 最新章节
final String columnNewChapter = 'newChapter';
// 总章节数
final String columnChapterCount = 'chapterCount';
// 当前章节
final String columnCurrentChapter = 'currentChapter';
// 当前章节数
final String columnCurrentChapterNum = 'currentChapterNum';
// 书源规则
final String columnSource = 'source';
// 上次更新时间
final String columnLastUpdateTime = 'lastUpdateTime';
// 上次阅读时间
final String columnLastReadTime = 'lastReadTime';

class Shelf {
  int id;
  String name;
  String author;
  String cover;
  String newChapter;
  int chapterCount;
  String currentChapter;
  int currentChapterNum;
  String source;
  int lastUpdateTime;
  int lastReadTime;

  Shelf({
    this.name,
    this.author,
    this.cover,
    this.newChapter,
    this.chapterCount,
    this.currentChapter,
    this.currentChapterNum,
    this.source,
    this.lastUpdateTime,
    this.lastReadTime
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      columnName: name,
      columnAuthor: author,
      columnCover: cover,
      columnNewChapter: newChapter,
      columnChapterCount: chapterCount,
      columnCurrentChapter: currentChapter,
      columnCurrentChapterNum: currentChapterNum,
      columnSource: source,
      columnLastUpdateTime: lastUpdateTime,
      columnLastReadTime: lastReadTime
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Shelf.fromJson(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    author = map[columnAuthor];
    cover = map[columnCover];
    newChapter = map[columnNewChapter];
    chapterCount = map[columnChapterCount];
    currentChapter = map[columnCurrentChapter];
    currentChapterNum = map[columnCurrentChapterNum];
    source = map[columnSource];
    lastUpdateTime = map[columnLastUpdateTime];
    lastReadTime = map[columnLastReadTime];
  }
}

class ShelfProvider {

  Future open() async {
    db = await openDatabase('my_db.db', version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $tableShelf ( 
            $columnId integer primary key autoincrement, 
            $columnName text not null, 
            $columnAuthor text not null, 
            $columnCover text not null, 
            $columnNewChapter text not null, 
            $columnChapterCount integer not null, 
            $columnCurrentChapter text not null, 
            $columnCurrentChapterNum integer not null, 
            $columnSource text not null, 
            $columnLastUpdateTime integer not null, 
            $columnLastReadTime integer not null)
          ''');
        });
  }

  Future<Shelf> insert(Shelf shelf) async {
    print(shelf.toJson());
    shelf.id = await db.insert(tableShelf, shelf.toJson());
    return shelf;
  }

  Future<Shelf> getShelf(int id) async {
    List<Map> maps = await db.query(tableShelf,
        columns: [columnId, columnCover, columnName],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Shelf.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Shelf>> getAll() async {
    List<Map> maps = await db.query(tableShelf);
    List<Shelf> books = [];
    for(Map item in maps) {
      books.add(Shelf.fromJson(item));
    }
    return books;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableShelf, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Shelf shelf) async {
    return await db.update(tableShelf, shelf.toJson(),
        where: '$columnId = ?', whereArgs: [shelf.id]);
  }

  Future close() async => db.close();
}