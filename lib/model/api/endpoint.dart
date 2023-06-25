class Endpoint {
  static const String baseUrl = 'https://13.210.163.192:8080';
  static const String login = '/users/auth/login';
  static const String verify = '/users/auth/verify';
  static const String checkUsernameEmail = '/users/auth/verify/unique';
  static const String register = '/users/auth/register';
  static const String userProfile = '/users/profile';
  static const String userChangePassword = '/users/profile/password';
  static const String readingLists = '/users/reading-lists';
  static const String transactions = '/users/transactions';
  static const String counselors = '/users/counselors';
  static const String publicArticles = '/users/public/articles';
  static const String publicCounselor = '/users/public/counselors';
  static const String publicCareer = '/users/public/careers';
  static const String getTopics = '/users/public/topics';
  static const String getArticles = '/users/articles';
  static const String getArticlesNoLogin = '/users/public/articles';
}
