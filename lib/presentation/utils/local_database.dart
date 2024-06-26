import 'package:shared_preferences/shared_preferences.dart';

class LocalDataBase {
  static saveData(String key, value) async {
    final SharedPreferences dataSave = await SharedPreferences.getInstance();
    dataSave.setString(key, value);
  }
  static Future<String?> getData(String key) async {
    final SharedPreferences dataSave = await SharedPreferences.getInstance();
    return dataSave.getString(key);
  }

  static removeData() async {
    final SharedPreferences dataSave = await SharedPreferences.getInstance();
    dataSave.clear();
  }

  static removeDataByName(String name) async {
    final SharedPreferences dataSave = await SharedPreferences.getInstance();
    dataSave.remove(name);
  }

 static savePrivateKey(String privateKey, address) async {
    LocalDataBase.saveData("pkey", privateKey);
    LocalDataBase.saveData("address", address);
  }
}
