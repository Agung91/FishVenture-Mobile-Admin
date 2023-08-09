import 'package:admin/modules/pond/model/model_pond.dart';

abstract class PondService {
  Future<List<PondModel>> getListPond();
}
