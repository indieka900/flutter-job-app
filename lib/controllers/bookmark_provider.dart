import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:flutter_nodejs_app/models/response/bookmarks/allbokmarks.dart';
import 'package:flutter_nodejs_app/services/helpers/book_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/common/exports.dart';

class BookMarkNotifier extends ChangeNotifier {
  Future<List<AllBookmarks>>? allbookmarks;

  List<String> _jobs = [];

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  addJob(String jobId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _jobs.insert(0, jobId);
    prefs.setStringList('job', _jobs);
    notifyListeners();
  }

  deleteJob(String jobId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _jobs.remove(jobId);
    prefs.setStringList('job', _jobs);
    prefs.remove(jobId);
    notifyListeners();
  }

  Future<void> loadjobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var job = prefs.getStringList('job');
    if (job != null) {
      job = _jobs;
    }
  }

  addBookmark(BookmarkReqModel model, String jobId) {
    BookMarkHelper.addBookmar(model).then((response) {
      addJob(jobId);
      if (response[0]) {
        Get.snackbar(
          'Bookmark added succesfully',
          'Please check bookmark folder',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.bookmark),
        );
      } else {
        Get.snackbar(
          'Failed to add bookmark',
          'Please check your internet and try again',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  deleteBookmark(String jobId, String id) {
    BookMarkHelper.deleteBookmark(id).then((response) {
      
      if (response) {
        deleteJob(jobId);
        Get.snackbar(
          'Bookmark deleted succesfully',
          'Please check bookmark folder',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.bookmark),
        );
      } else {
        Get.snackbar(
          'Failed to delete bookmark',
          'Please check your credentials and internet',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  getBookmarks() {
    allbookmarks = BookMarkHelper.getBookmarks();
  }
}
