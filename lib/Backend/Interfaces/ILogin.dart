class ILogin {
  Future<void> getLoginData() async {}
  String login(String username, String password) {}
  void logout() {}
}
