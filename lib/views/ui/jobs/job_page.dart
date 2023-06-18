import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/views/common/app_bar.dart';
import 'package:flutter_nodejs_app/views/common/custom_outline_btn.dart';
import 'package:flutter_nodejs_app/views/common/exports.dart';
import 'package:flutter_nodejs_app/views/common/height_spacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/request/bookmarks/bookmarks_model.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, _, child) {
      _.getJob(widget.id);
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: widget.title,
            actions: [
              Consumer<BookMarkNotifier>(builder: (context, _, child) {
                _.loadjobs();
                return GestureDetector(
                  onTap: () async {
                    if (_.jobs.contains(widget.id)) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? id = prefs.getString(widget.id);
                      _.deleteBookmark(widget.id, id!);
                      //
                    } else {
                      BookmarkReqModel model =
                          BookmarkReqModel(jobId: widget.id);
                      _.addBookmark(model, widget.id);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.0.w),
                    child: !_.jobs.contains(widget.id)
                        ? const Icon(Fontisto.bookmark)
                        : const Icon(Fontisto.bookmark_alt),
                  ),
                );
              }),
            ],
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          ),
        ),
        body: FutureBuilder(
            future: _.job,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Color(kOrange.value)),
                );
              } else if (snapShot.hasError) {
                return Center(
                  child: Text("Error occured ${snapShot.error}"),
                );
              } else {
                final job = snapShot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          const HeightSpacer(size: 30),
                          Container(
                            width: width,
                            height: hieght * 0.27,
                            color: Color(kLightGrey.value),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(job!.imageUrl),
                                ),
                                const HeightSpacer(size: 10),
                                ReusableText(
                                  text: job.title,
                                  style: appstyle(
                                      22, Color(kDark.value), FontWeight.w600),
                                ),
                                const HeightSpacer(size: 5),
                                ReusableText(
                                  text: job.location,
                                  style: appstyle(16, Color(kDarkGrey.value),
                                      FontWeight.normal),
                                ),
                                const HeightSpacer(size: 15),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomOutlineBtn(
                                        text: job.contract,
                                        color1: Color(kOrange.value),
                                        color2: Color(kLight.value),
                                        width: width * 0.26,
                                        height: hieght * 0.04,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          ReusableText(
                                            text: job.salary,
                                            style: appstyle(
                                              22,
                                              Color(kDark.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.2,
                                            child: ReusableText(
                                              text: '/${job.period}',
                                              style: appstyle(
                                                22,
                                                Color(kDark.value),
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          ReusableText(
                            text: 'Job Description',
                            style: appstyle(
                                22, Color(kDark.value), FontWeight.w600),
                          ),
                          const HeightSpacer(size: 10),
                          Text(
                            job.description,
                            textAlign: TextAlign.justify,
                            maxLines: 8,
                            style: appstyle(
                              16,
                              Color(kDarkGrey.value),
                              FontWeight.normal,
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          ReusableText(
                            text: 'Requirements',
                            style: appstyle(
                                22, Color(kDark.value), FontWeight.w600),
                          ),
                          const HeightSpacer(size: 10),
                          SizedBox(
                            height: hieght * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: job.requirements.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final req = job.requirements[index];
                                String bullet = "\u2022";
                                return Text(
                                  "$bullet $req\n",
                                  maxLines: 4,
                                  style: appstyle(
                                    16,
                                    Color(kDarkGrey.value),
                                    FontWeight.normal,
                                  ),
                                );
                              },
                            ),
                          ),
                          const HeightSpacer(size: 80),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CustomOutlineBtn(
                            text: "Apply Now",
                            width: width,
                            height: hieght * 0.06,
                            color1: Color(kLight.value),
                            color2: Color(kOrange.value),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      );
    });
  }
}
