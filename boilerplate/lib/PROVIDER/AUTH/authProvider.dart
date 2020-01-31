import 'dart:async';
import 'dart:convert';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/MODEL/AUTH/login.dart';
import 'package:Npay/MODEL/general.dart';
import 'package:http/http.dart' show Client, Response;

class AuthProvider {
  Client client = Client();
  final userRepository = Constant();

  Future fetchLogin(var nohp,var deviceid) async {
    return await client.post(ApiService().baseUrl+"auth/login",
        body: {
          "nohp":"$nohp",
          "deviceid":"$deviceid",
        }).then((Response response) {
      print(response.body);
      var results;
      if(response.statusCode == 200){
        results = LoginModel.fromJson(jsonDecode(response.body));
      }else{
        results = General.fromJson(jsonDecode(response.body));
      }
      print(results);
      return results;
    });
  }





}
