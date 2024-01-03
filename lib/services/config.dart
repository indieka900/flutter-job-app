class Config {
  static const apiUrl = "django-api-seven.vercel.app";
  static const String loginUrl = "/login";
  static const String signupUrl = "/register";
  //static const String jobs = "/api/jobs";
  static const String search = "/job";
  static const String job = "/";
  static const String profileUrl = "/users";
  static const String bookmarkUrl = "/bookmarks";
  static const String deletebookmarkUrl = "/bookmark/delete";
}

/*
 path('jobs/<str:pk>', views.get_job),
    path('job', views.searchJob),
    path('users/<str:pk>', views.UserDetail.as_view(), name='user-detail'),
    path('bookmarks/<str:pk>', views.BookmarkView.as_view()),
    path('bookmark/delete/<str:pk>', views.delete_bookmark),
 */