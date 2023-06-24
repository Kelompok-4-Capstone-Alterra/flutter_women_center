class Endpoint {
  static const String baseUrl = 'https://13.210.163.192:8080';
  static const String login = '/users/auth/login';
  static const String verify = '/users/auth/verify';
  static const String checkUsernameEmail = '/users/auth/verify/unique';
  static const String register = '/users/auth/register';
  static const String userProfile = '/users/profile';
  static const String getTopics = '/users/public/topics';
  static const String getCounselorList = '/users/public/counselors';
  static const String getCounselorDetail = '/users/counselors';
  static const String voucher = '/users/vouchers';
  static const String postTransaction = '/users/transactions';
  static const String getTransactionDetail = '/users/transactions/';
}
