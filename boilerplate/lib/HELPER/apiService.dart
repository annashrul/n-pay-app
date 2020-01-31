import 'package:shared_preferences/shared_preferences.dart';

class ApiService{
  final logo = 'assets/images/logo.jpg';
  final versionCode = '1.0.0';
  final baseUrl         = 'http://ptnetindo.com:6691/api/v1/';
  final baseUrl2         = 'http://thaibah.com:3000/api/v1/';
  final String username = 'netindo';
  final String password = 'admin1234!@';
  final bool showCode   = true;
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }
  Future<String> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    return id;
  }
  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    return name;
  }
  Future<String> getPicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String picture = prefs.getString('picture');
    return picture;
  }
  Future<String> getReff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String reff = prefs.getString('kd_referral');
    return reff;
  }
  Future<int> getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pin = prefs.getString('pin');
    return int.parse(pin);
  }
  Future<String> getNoHp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nohp = prefs.getString('nohp');
    return nohp;
  }

}