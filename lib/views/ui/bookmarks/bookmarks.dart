import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/models/response/bookmarks/allbokmarks.dart';
import 'package:flutter_nodejs_app/views/common/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';
import 'widgets/bookmark_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    var jobNotifier = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Bookmarks",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookMarkNotifier, child) {
          bookMarkNotifier.getBookmarks();
          return FutureBuilder<List<AllBookmarks>>(
            future: bookMarkNotifier.allbookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(kOrange.value),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ocured was ${snapshot.error}'),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: ReusableText(
                    text: "You have no bookmarks yet",
                    style: appstyle(25, kDark, FontWeight.bold),
                  ),
                );
              } else {
                final bookmarks = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: bookmarks!.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];
                    print(bookmark.job.updatedAt);
                    return BookMarkTileWidget(
                      job: bookmark.job,
                      posted: jobNotifier
                          .formatRelativeTime(bookmark.job.updatedAt),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
