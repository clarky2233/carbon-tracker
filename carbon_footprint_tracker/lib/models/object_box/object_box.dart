import '../../objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

late Store store;

class ObjectBox {
  static Future<Store> getStore(String? path) async {
    if (Store.isOpen(path)) {
      return Store.attach(getObjectBoxModel(), path);
    }
    return await openStore(directory: path);
  }

  static Future<String> storePath() async {
    final docsDir = await getApplicationDocumentsDirectory();
    return p.join(docsDir.path, "carbon-tracker");
  }
}
