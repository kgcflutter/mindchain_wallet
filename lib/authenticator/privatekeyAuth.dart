import 'package:web3dart/credentials.dart';
import '../presentation/utils/local_database.dart';

Future<Credentials> getCredentials() async {
  String? privateKeys = await LocalDataBase.getData("pkey");
  if (privateKeys != null) {
    return EthPrivateKey.fromHex(privateKeys);
  } else {
    throw Exception('Invalid private key.');
  }
}