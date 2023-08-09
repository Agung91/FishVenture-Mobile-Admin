import 'package:admin/common/http/http.dart';
import 'package:admin/config/hosts.dart';
import 'package:admin/modules/pond/model/service_pond.dart';

class PondHttpRepo extends HttpService implements PondService {
  @override
  Future<dynamic> getListPond() async {
    try {
      final response = await get('$host/list-pond');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
