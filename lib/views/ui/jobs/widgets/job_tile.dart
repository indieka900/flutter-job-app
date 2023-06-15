import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/models/response/jobs/jobs_response.dart';
import 'package:flutter_nodejs_app/views/common/app_style.dart';
import 'package:flutter_nodejs_app/views/common/reusable_text.dart';
import 'package:flutter_nodejs_app/views/common/width_spacer.dart';
import 'package:flutter_nodejs_app/views/ui/jobs/job_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({super.key, required this.job});

  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(title: job.company, id: job.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: hieght * 0.15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(job.imageUrl),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ReusableText(
                            text: job.company,
                            style: appstyle(
                              20,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job.title,
                              style: appstyle(
                                20,
                                Color(kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: job.salary,
                      style: appstyle(22, Color(kDark.value), FontWeight.w600),
                    ),
                    ReusableText(
                      text: "/${job.period}",
                      style: appstyle(20, Color(kDark.value), FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
