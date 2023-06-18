import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/models/response/jobs/jobs_response.dart';
import 'package:flutter_nodejs_app/services/helpers/jobs_helper.dart';
import 'package:flutter_nodejs_app/views/common/exports.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/widgets/job_tile.dart';
import 'package:flutter_nodejs_app/views/ui/search/widgets/custom_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../common/height_spacer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var jobLists = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: CustomField(
          hintText: "Search a Job",
          onEditingComplete: () {
            setState(() {});
          },
          controller: controller,
          suffixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(AntDesign.search1),
          ),
        ),
        elevation: 0,
      ),
      body: controller.text.isEmpty
          ? const SearchLoading(text: "Start Seaching For Jobs")
          : Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: FutureBuilder<List<JobsResponse>>(
              future: JobsHelper.searchJob(controller.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Color(kOrange.value)),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occured ${snapshot.error}"),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const SearchLoading(
                    text: 'No Result Found',
                  );
                } else {
                  final jobs = snapshot.data;
                  return ListView.builder(
                    itemCount: jobs!.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return VerticalTileWidget(
                        job: job,
                        posted: jobLists.formatRelativeTime(job.updatedAt),
                      );
                    },
                  );
                }
              },
            ),
          ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/optimized_search.png"),
          const HeightSpacer(size: 10),
          ReusableText(
            text: text,
            style: appstyle(25, Color(kDark.value), FontWeight.bold),
          )
        ],
      ),
    );
  }
}
