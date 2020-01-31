import 'package:Npay/MODEL/base_model.dart';
import 'package:Npay/PROVIDER/provider.dart';
import 'package:rxdart/rxdart.dart';


abstract class BaseBloc<T extends BaseModel> {
  final repository = Provider();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}