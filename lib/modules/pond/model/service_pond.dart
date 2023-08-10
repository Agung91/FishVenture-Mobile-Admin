import 'package:admin/modules/pond/model/input_update_pond.dart';
import 'package:admin/modules/pond/model/model_pond.dart';

abstract class PondService {
  Future<List<PondModel>> getListPond();
  Future<String?> updatePond(UpdatePondInput input);
}

