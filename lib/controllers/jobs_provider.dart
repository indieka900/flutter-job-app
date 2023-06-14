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
}
