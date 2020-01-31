
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:rxdart/rxdart.dart';

import '../base_bloc.dart';

class PpobPraBloc extends BaseBloc{
  bool _isDisposed = false;
  final PublishSubject<PpobPraModel> _serviceController = new PublishSubject<PpobPraModel>();
  Observable<PpobPraModel> get getResult => _serviceController.stream;
  fetchPpobPra(var type,var nohp) async {
    if(_isDisposed) {
      print('false');
    }else{
      PpobPraModel ppobPraModel =  await repository.fetchPpobPra(type,nohp);
      _serviceController.sink.add(ppobPraModel);
    }
  }
  void dispose() {
    _serviceController.close();
    _isDisposed = true;
  }
}

final ppobPraBloc       = PpobPraBloc();
