import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

typedef StringMapStoreRef = StoreRef<String, Map<String, Object?>>;

StringMapStoreRef getStoreRef(String storeKey) {
  return stringMapStoreFactory.store(storeKey);
}

Future<Database?> openDatabase() async {
  try {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'sembast_storage.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    return database;
  } catch (e) {
    return null;
  }
}
