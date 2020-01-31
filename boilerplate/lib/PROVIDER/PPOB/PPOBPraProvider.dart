import 'dart:async';
import 'dart:convert';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client, Response;

class PpobPraProvider {
  Client client = Client();
  final userRepository = ApiService();
  Future<PpobPraModel> fetchPpobPra(String type,var nohp) async{
    final token = await userRepository.getToken();
    var _url;
    var spl = type.split("|");
    if(type == 'E_MONEY' && nohp==''){
      _url = 'ppob/get/E_MONEY/list';
    }else{
      if(spl[0] == 'emoney'){
        _url = 'ppob/get/E_MONEY/$nohp?provider='+spl[1];
      }else{
        _url = 'ppob/get/$type/$nohp';
      }
    }

    final response = await client.get(
        ApiService().baseUrl+_url,
        headers: {'Authorization':token,'username':ApiService().username,'password':ApiService().password}
    );
    print("########################### PRODUK PPOB PRABAYAR #################################");
    print(response.body);
    if (response.statusCode == 200) {
      return compute(ppobPraModelFromJson, response.body);
    } else {
      throw Exception('Failed to load $type');
    }
  }



}
