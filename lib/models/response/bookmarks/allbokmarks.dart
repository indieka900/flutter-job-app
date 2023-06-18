import 'dart:convert';

List<AllBookmarks> allBookmarksFromJson(String str) => List<AllBookmarks>.from(
    json.decode(str).map((x) => AllBookmarks.fromJson(x)));

// String allBookmarksToJson(List<AllBookmarks> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookmarks {
  final String id;
  final Job job;
  final String userId;
  final DateTime createdAt;

  AllBookmarks({
    required this.id,
    required this.job,
    required this.userId,
    required this.createdAt,
  });

  factory AllBookmarks.fromJson(Map<String, dynamic> json) => AllBookmarks(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "job": job.toJson(),
  //       "userId": userId,
  //       "created_at": createdAt.toIso8601String(),
  //     };
}

class Job {
  final String id;
  final String title;
  final String location;
  final String company;
  final String imageUrl;
  final String salary;
  final String period;
  final DateTime updatedAt;

  Job({
    required this.salary,
    required this.period,
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.imageUrl,
    required this.updatedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        salary: json["salary"],
        period: json["period"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        imageUrl: json["image_url"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "title": title,
  //       "location": location,
  //       "company": company,
  //       "image_url": imageUrl,
  //       "updated_at": updatedAt.toIso8601String(),
  //     };
}
