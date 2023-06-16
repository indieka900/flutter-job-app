import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/views/common/exports.dart';
import 'package:flutter_nodejs_app/views/common/height_spacer.dart';
import 'package:flutter_nodejs_app/views/common/width_spacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../models/response/jobs/jobs_response.dart';

class JobHorizontalTile extends StatefulWidget {
  const JobHorizontalTile(
      {super.key, this.onTap, required this.job, required this.posted});

  final void Function()? onTap;
  final JobsResponse job;
  final String posted;

  @override
  State<JobHorizontalTile> createState() => _JobHorizontalTileState();
}

class _JobHorizontalTileState extends State<JobHorizontalTile> {
  @override
  Widget build(BuildContext context) {
    //bool imageaerror = false;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          color: Color(kLightGrey.value),
          width: width * 0.8,
          height: hieght * 0.27,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(kDarkGrey.value),
                        backgroundImage: NetworkImage(widget.job.imageUrl),
                        onBackgroundImageError: (_, __) {
                          setState(() {});
                        },
                      ),
                      const WidthSpacer(width: 12),
                      ReusableText(
                        text: widget.job.company,
                        style:
                            appstyle(22, Color(kDark.value), FontWeight.w600),
                      ),
                    ],
                  ),
                  const HeightSpacer(size: 15),
                  ReusableText(
                    text: widget.job.title,
                    style: appstyle(20, Color(kDark.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: widget.job.location,
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                  ),
                  const HeightSpacer(size: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          ReusableText(
                            text: widget.job.salary,
                            style: appstyle(
                                23, Color(kDark.value), FontWeight.w600),
                          ),
                          ReusableText(
                            text: '/${widget.job.period}',
                            style: appstyle(
                                23, Color(kDarkGrey.value), FontWeight.w600),
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: const Icon(Ionicons.chevron_forward),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ReusableText(
                  text: widget.posted,
                  style: appstyle(
                    15,
                    Color(kDark.value),
                    FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
