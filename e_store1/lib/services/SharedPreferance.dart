import 'package:shared_preferences/shared_preferences.dart';

class SaveUserDataLocal {
  static const String userIdKey = "user_id";
  static const String userNameKey = "user_name";
  static const String userEmailKey = "user_email";
  static const String userPasswordKey = "user_password";
  static const String userImageKey = "user_image";
  static const String onboardingKey = "onboarding_status";

  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('All shared preferences data cleared.');
  }

  Future<bool> saveUserID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, id);
  }

  Future<bool> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, name);
  }

  Future<bool> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, email);
  }

  Future<bool> saveUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPasswordKey, password);
  }

  Future<bool> saveUserImage(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, image);
  }

  Future<bool> saveOnboardingStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(onboardingKey, status);
  }

  Future<bool?> getOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey);
  }

  Future<String?> getSaveUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getSaveUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getSaveUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getSaveUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPasswordKey);
  }

  Future<String?> getSaveUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }
}
