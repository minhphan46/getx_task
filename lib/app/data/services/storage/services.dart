import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    // if we had storage, the key will not null so will skip this line, else return []
    await _box.write(taskKey, []);
    return this;
  }

  /// read our data from storage, if u storage string type, this will return string type, ...
  T read<T>(String key) {
    return _box.read(key);
  }

  /// write data to storage
  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
