
import 'dart:convert';

BookmarkReqModel bookmarkReqModelFromJson(String str) => BookmarkReqModel.fromJson(json.decode(str));

String bookmarkReqModelToJson(BookmarkReqModel data) => json.encode(data.toJson());

class BookmarkReqModel {
    final String jobId;

    BookmarkReqModel({
        required this.jobId,
    });

    factory BookmarkReqModel.fromJson(Map<String, dynamic> json) => BookmarkReqModel(
        jobId: json["job_id"],
    );

    Map<String, dynamic> toJson() => {
        "job_id": jobId,
    };
}
