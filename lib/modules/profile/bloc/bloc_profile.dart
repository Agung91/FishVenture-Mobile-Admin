import 'package:admin/core/auth/bloc/authenticated.dart';
import 'package:admin/modules/profile/model/model_profile.dart';
import 'package:admin/modules/profile/repo/repo_profile.dart';
import 'package:sstream/sstream.dart';

class ProfileBloc extends Authenticated {
  ProfileBloc(this._repo) {
    getProfile();
  }

  final ProfileHttpRepo _repo;

  final profile = SStream<ProfileModel?>(null);

  Future<void> getProfile() async {
    try {
      final response = await _repo.getProfile();
      profile.add(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> onLogin() async {
    getProfile();
  }

  @override
  Future<void> onLogout() async {
    profile.add(null);
  }
}
