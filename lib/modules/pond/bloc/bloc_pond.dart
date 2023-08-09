import 'package:admin/modules/pond/model/model_pond.dart';
import 'package:admin/modules/pond/repo/repo_pond.dart';
import 'package:sstream/sstream.dart';

class PondBloc {
  PondBloc(this._repo);

  final PondHttpRepo _repo;

  final listPond = SStream<List<PondModel>>([]);

  Future<void> getPonds() async {
    try {
      final response = await _repo.getListPond();
      listPond.add(response);
    } catch (e) {
      rethrow;
    }
  }
}
