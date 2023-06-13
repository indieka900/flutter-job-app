import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    String token;
    User user;

    UserResponse({
        required this.token,
        required this.user,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    String id;
    String profile;

    User({
        required this.id,
        required this.profile,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "profile": profile,
    };
}