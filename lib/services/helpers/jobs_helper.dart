import 'package:flutter_nodejs_app/models/response/jobs/get_job.dart';
import 'package:flutter_nodejs_app/models/response/jobs/jobs_response.dart';
import 'package:http/http.dart' as https;

import '../config.dart';

class JobsHelper {
  static var client = https.Client();
  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.job);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    //await prefs.setBool('loading', false);
    //print(response.body);
    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception("Failed to get jobs");
    }
  }

  static Future<JobsResponse> getRecent() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.job);
    //await prefs.setBool('loading', true);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    //await prefs.setBool('loading', false);
    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      var recent = jobList.last;
      return recent;
    } else {
      throw Exception("Failed to get a job");
    }
  }

  static Future<GetJobRes> getJob(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, '${Config.job}/$id');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var jobList = getJobResFromJson(response.body);
      var recent = jobList;
      return recent;
    } else {
      throw Exception("Failed to get a job");
    }
  }
}
