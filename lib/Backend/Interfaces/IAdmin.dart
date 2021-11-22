class IAdmin {
  Future<bool> createAdminAccount(
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password) async {
    return true;
  }

  void deleteAdminAccount() {}
  void updateAdminAccount() {}
  bool verifyAdmin(String password) {
    return true;
  }
}
