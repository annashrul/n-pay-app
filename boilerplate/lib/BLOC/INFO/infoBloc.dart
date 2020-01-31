
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:rxdart/rxdart.dart';

import '../base_bloc.dart';

class InfoBloc extends BaseBloc{
  bool _isDisposed = false;
  final PublishSubject<InfoModel> _serviceController = new PublishSubject<InfoModel>();
  Observable<InfoModel> get getResult => _serviceController.stream;
  fetchInfo() async {
    if(_isDisposed) {
      print('false');
    }else{
      InfoModel infoModel =  await repository.fetchInfo();
      _serviceController.sink.add(infoModel);
    }
  }
  void dispose() {
    _serviceController.close();
    _isDisposed = true;
  }





}

final infoBloc       = InfoBloc();
