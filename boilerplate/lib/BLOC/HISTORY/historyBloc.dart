import 'package:Npay/MODEL/HISTORY/historyModel.dart';
import 'package:rxdart/rxdart.dart';
import '../base_bloc.dart';

class HistoryBloc extends BaseBloc{
  bool _isDisposed = false;
  final PublishSubject<HistoryModel> _serviceController = new PublishSubject<HistoryModel>();
  Observable<HistoryModel> get getResult => _serviceController.stream;
  fetchHistoryList(var param, var page, var limit,var from,var to, var q) async {
    if(_isDisposed) {
      print('false');
    }else{
      HistoryModel history =  await repository.fetchHistory(param, page, limit, from, to, q);
      _serviceController.sink.add(history);
    }
  }

  void dispose() {
    _serviceController.close();
    _isDisposed = true;
  }
}



final historyBloc     = HistoryBloc();
