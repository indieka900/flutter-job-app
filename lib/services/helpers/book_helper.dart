//import 'package:flutter_nodejs_app/models/bookmark_res.dart';
import 'dart:convert';

import 'package:flutter_nodejs_app/models/bookmark_res.dart';
import 'package:flutter_nodejs_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:flutter_nodejs_app/models/response/bookmarks/allbokmarks.dart';
import 'package:flutter_nodejs_app/services/config.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();
  //add bookmark
  static Future<List<dynamic>> addBookmar(BookmarkReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString('userId');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, '${Config.bookmarkUrl}/$userID');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      String bookMarkId = bookmarkResModelFromJson(response.body).id;
      String jobId = bookmarkResModelFromJson(response.body).job.id;
      prefs.setString(jobId, bookMarkId);
      return [true, bookMarkId];
    } else {
      return [false];
    }
  }

//get all bookmarks
  static Future<List<AllBookmarks>> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString('userId');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, '${Config.bookmarkUrl}/$userID');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var bookmarks = allBookmarksFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception("Failed to load bookmarks");
    }
  }

  //delete bookmark
  static Future<bool> deleteBookmark(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiUrl, '${Config.deletebookmarkUrl}/$id');
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
