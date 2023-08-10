import 'package:admin/common/model/model_status.dart';
import 'package:admin/modules/pond/model/input_update_pond.dart';
import 'package:admin/modules/pond/model/model_pond.dart';
import 'package:admin/modules/pond/repo/repo_pond.dart';
import 'package:sstream/sstream.dart';

class PondBloc {
  PondBloc(this._repo) {
    getPonds();
  }

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

  Future<void> updatePondReviewed(String pondID) async {
    try {
      await _repo.updatePond(
        UpdatePondInput(pondID: pondID, status: StatusSubmission.reviewed),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePondActived(String pondID) async {
    try {
      await _repo.updatePond(
        UpdatePondInput(pondID: pondID, status: StatusSubmission.actived),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePondDisabled(String pondID) async {
    try {
      await _repo.updatePond(
        UpdatePondInput(pondID: pondID, status: StatusSubmission.disabled),
      );
    } catch (e) {
      rethrow;
    }
  }
}
