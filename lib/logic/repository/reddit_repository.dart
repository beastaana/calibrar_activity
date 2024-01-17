// import 'package:calibrar_activity/logic/database/database_service.dart';
// import 'package:calibrar_activity/logic/model/reddit_model.dart';

// abstract class RedditRepository {
//   Future<List<RedditModel>> getRedditPosts({String query});

//   Future<RedditModel?> getRedditPost({int id});

//   Future<int> createRedditPost(RedditModel data);

//   Future<int> updateRedditPost(RedditModel data);

//   Future<int> deleteRedditPost(int id);
// }

// class RedditRepositoryImplementation implements RedditRepository {
//   final dbProvider = DatabaseService.dbProvider;
  
//   @override
//   Future<int> createRedditPost(RedditModel data) async {
//     final db = await dbProvider.database;
//       var result = await db.insert(redditTable, data.toJson());
//       return result;
//     }
  
//     @override
//     Future<int> deleteRedditPost(int id) async{
//       final db = await dbProvider.database;
//       var result = await db.delete(redditTable, where: 'id = ?', whereArgs: [id]);
//       return result;
//     }

//     @override
//     Future<RedditModel?> getRedditPost({List<String>? columns, int? id}) async {
//       final db = await dbProvider.database;
//       var result = await db.query(redditTable,columns: columns,  where: 'id = ?', whereArgs: [id]);
      
//       List<RedditModel> posts = result.isNotEmpty ? result.map((user) => RedditModel.fromJson(user)).toList() : [];
//       RedditModel? post = posts.isNotEmpty ? posts[0] : null;
      
//       return post;
//     }
  
//     @override
//     Future<List<RedditModel>> getRedditPosts({List<String> columns, String query}) async{
//       final db = await dbProvider.database;

//       List<Map<String, dynamic>> result;
//       if (query != null && query != '') {
//         if (query.isNotEmpty) {
//           result = await db.query(redditTable,
//               columns: columns, where: 'name LIKE ?', whereArgs: ['%$query%']);
//         }
//       } else {
//         result = await db.query(redditTable, columns: columns);
//       }

//       List<RedditModel> posts = result.isNotEmpty
//           ? result.map((post) => RedditModel.fromJson(posts)).toList()
//           : [];
//       return posts;
//     }
  
//     @override
//     Future<int> updateRedditPost(RedditModel data) async{
//     final db = await dbProvider.database;
//       var result = db.update(redditTable, data.toJson(),
//           where: 'id = ?', whereArgs: [data.id]);
//       return result;
//   }

// }