import 'dart:async';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client, Response;

class InfoProvider {
  Client client = Client();
  final userRepository = ApiService();
  Future<InfoModel> fetchInfo() async{
    final token = await userRepository.getToken();
    final username = userRepository.username;
    final password = userRepository.password;
    final response = await client.get(
        ApiService().baseUrl+'info',
        headers: {'Authorization':token,'username':username,'password':password}
    );
    print("########################### INFO #################################");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return compute(infoModelFromJson, response.body);
    } else {
      throw Exception('Failed to load info');
    }
  }
}
