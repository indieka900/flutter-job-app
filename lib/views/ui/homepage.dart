import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/views/common/app_bar.dart';
import 'package:flutter_nodejs_app/views/common/app_style.dart';
import 'package:flutter_nodejs_app/views/common/drawer/drawer_widget.dart';
import 'package:flutter_nodejs_app/views/common/heading_widget.dart';
import 'package:flutter_nodejs_app/views/common/height_spacer.dart';
import 'package:flutter_nodejs_app/views/common/search.dart';
import 'package:flutter_nodejs_app/views/common/vertical_shimmer.dart';
import 'package:flutter_nodejs_app/views/common/vertical_tile.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/job_page.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:flutter_nodejs_app/views/ui/search/searchpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //var imageNotifier = Provider.of<ImageUpoader>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Consumer<ProfileNotifier>(builder: (context, snapshot, _) {
                snapshot.getPrefs();
                return CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(snapshot.profileurl),
                );
              }),
            )
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<JobsNotifier>(builder: (context, _, child) {
        _.getJobs();
        _.getrecent();
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const HeightSpacer(size: 10),
                  Text(
                    "Search \nFind & Apply",
                    style: appstyle(40, Color(kDark.value), FontWeight.bold),
                  ),
                  const HeightSpacer(size: 40),
                  SearchWidget(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                  ),
                  const HeightSpacer(size: 30),
                  HeadingWidget(
                    text: "Popular Jobs",
                    onTap: () {},
                  ),
                  const HeightSpacer(size: 15),
                  SizedBox(
                      height: hieght * 0.28,
                      child: FutureBuilder(
                        future: _.jobList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const HorizontalShimmer();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error ocured ${snapshot.error}'),
                            );
                          } else {
                            final jobs = snapshot.data;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: jobs!.length,
                              itemBuilder: (context, index) {
                                final job = jobs[index];
                                return JobHorizontalTile(
                                  onTap: () {
                                    Get.to(
                                      () => JobPage(
                                        title: job.company,
                                        id: job.id,
                                      ),
                                    );
                                  },
                                  job: job,
                                );
                              },
                            );
                          }
                        },
                      )),
                  const HeightSpacer(size: 20),
                  HeadingWidget(
                    text: "Recently Posted",
                    onTap: () {},
                  ),
                  const HeightSpacer(size: 20),
                  FutureBuilder(
                    future: _.recent,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const VerticalShimmer();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error ocured ${snapshot.error}'),
                        );
                      } else {
                        final job = snapshot.data;
                        return VerticalTile(
                          job: job,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
