import 'package:admin/modules/pool/model/input_create_pool.dart';

abstract class PoolService {
  Future<String?> createPool(CreatePoolInput input);
}
