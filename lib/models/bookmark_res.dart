// import 'dart:convert';

// List<BookmarkResModel> bookmarkResModelFromJson(String str) => List<BookmarkResModel>.from(json.decode(str).map((x) => BookmarkResModel.fromJson(x)));

// String bookmarkResModelToJson(List<BookmarkResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class BookmarkResModel {
//     BookmarkResModel({
//         required this.id,
//         required this.job,
//         required this.userId,
//         required this.title,
//         required this.imageUrl,
//         required this.company,
//         required this.location,
//     });

//     final String id;
//     final String job;
//     final String userId;
//     final String title;
//     final String imageUrl;
//     final String company;
//     final String location;

//     factory BookmarkResModel.fromJson(Map<String, dynamic> json) => BookmarkResModel(
//         id: json["_id"],
//         job: json["job"],
//         userId: json["userId"],
//         title: json["title"],
//         imageUrl: json["imageUrl"],
//         company: json["company"],
//         location: json["location"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "job": job,
//         "userId": userId,
//         "title": title,
//         "imageUrl": imageUrl,
//         "company": company,
//         "location": location,
//     };
// }
// To parse this JSON data, do
//
//     final bookmarkResModel = bookmarkResModelFromJson(jsonString);
import 'dart:convert';

BookmarkResModel bookmarkResModelFromJson(String str) => BookmarkResModel.fromJson(json.decode(str));

String bookmarkResModelToJson(BookmarkResModel data) => json.encode(data.toJson());

class BookmarkResModel {
    final String id;
    final Job job;
    final String userId;
    final DateTime createdAt;

    BookmarkResModel({
        required this.id,
        required this.job,
        required this.userId,
        required this.createdAt,
    });

    factory BookmarkResModel.fromJson(Map<String, dynamic> json) => BookmarkResModel(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job.toJson(),
        "userId": userId,
        "created_at": createdAt.toIso8601String(),
    };
}

class Job {
    final String id;
    final String title;
    final String location;
    final String company;
    final String imageUrl;
    final DateTime updatedAt;

    Job({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        required this.imageUrl,
        required this.updatedAt,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        imageUrl: json["image_url"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "image_url": imageUrl,
        "updated_at": updatedAt.toIso8601String(),
    };
}
