import 'package:flutter/foundation.dart';
import 'package:flutter_nodejs_app/models/response/jobs/jobs_response.dart';

import '../models/response/jobs/get_job.dart';
import '../services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recent;
  late Future<GetJobRes> job;

  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getrecent() {
    recent = JobsHelper.getRecent();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }

  String formatRelativeTime(DateTime dateTime) {
  

  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    if (difference.inSeconds == 0) {
      return "now";
    } else if (difference.inSeconds == 1) {
      return '1 sec ago';
    } else {
      return '${difference.inSeconds} secs ago';
    }
  } else if (difference.inMinutes < 60) {
    if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else {
      return '${difference.inMinutes} mins ago';
    }
  } else if (difference.inHours < 24) {
    if (difference.inHours == 1) {
      return '1 hour ago';
    } else {
      return '${difference.inHours} hours ago';
    }
  } else if (difference.inDays < 30) {
    if (difference.inDays == 1) {
      return '1 day ago';
    } else {
      return '${difference.inDays} days ago';
    }
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    if (months == 1) {
      return '1 month ago';
    } else {
      return '$months months ago';
    }
  } else {
    final years = difference.inDays ~/ 365;
    if (years == 1) {
      return '1 year ago';
    } else {
      return '$years years ago';
    }
  }
}

}
