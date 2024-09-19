import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late Box<dynamic> box;

  static Future<void> initialiseLocalStorage() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
    box = await Hive.openBox('appLocalPreference');
  }

  static void setFavProductID(List<int> data) {
    box.put(
      'dataList',
      data,
    );
  }

  static List<int> getFavProductID() {
    return box.get(
      'dataList',
      defaultValue: [-1],
    );
  }
}
