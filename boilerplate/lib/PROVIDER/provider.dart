import 'package:Npay/MODEL/HISTORY/historyModel.dart';
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:Npay/PROVIDER/HISTORY/historyProvider.dart';
import 'package:Npay/PROVIDER/INFO/infoProvider.dart';
import 'package:Npay/PROVIDER/PPOB/PPOBPraProvider.dart';

class Provider{
  final ppobPraProvider = PpobPraProvider();
  final historyProvider = HistoryProvider();
  final infoProvider    = InfoProvider();

  Future<PpobPraModel> fetchPpobPra(var type,var nohp) => ppobPraProvider.fetchPpobPra(type,nohp);
  Future<HistoryModel> fetchHistory(var param,var page,var limit,var from,var to, var q) => historyProvider.fetchHistory(param,page, limit, from, to,q);
  Future<InfoModel> fetchInfo() => infoProvider.fetchInfo();

}