import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/controllers/exports.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/widgets/job_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/exports.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobLists = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Jobs",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder(
        future: jobLists.jobList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error occured ${snapshot.error}"),
            );
          } else {
            final job = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: job!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final req = job[index];
                  return VerticalTileWidget(
                    posted:
                        jobLists.formatRelativeTime(req.updatedAt),
                    job: req,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
