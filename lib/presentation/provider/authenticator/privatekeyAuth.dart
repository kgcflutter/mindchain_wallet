import 'dart:async';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:web3dart/credentials.dart';

Future<Credentials> getCredentials() async {
  String? privateKeys = await LocalDataBase.getData("pkey");
  if (privateKeys != null) {
    return EthPrivateKey.fromHex(privateKeys);
  } else {
    throw Exception('Invalid private key.');
  }
}

Future<String> loadMyAddress() async {
  return (await LocalDataBase.getData("address"))!;
}
