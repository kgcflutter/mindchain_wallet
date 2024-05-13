import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindchain_wallet/presentation/utils/local_database.dart';
import 'package:web3dart/credentials.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class SignInSystem {
  static Future<bool> loginWithPrivateKey(String privateKey) async {
    try {
      if (privateKey.isNotEmpty) {
        Credentials credentials = EthPrivateKey.fromHex(privateKey.trim());
        await LocalDataBase.savePrivateKey(privateKey, credentials.address.hex);
        print('Login successful.');
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Invalid Private Key",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
        );
        return false;
      }
    } on FormatException catch (_) {
      Fluttertoast.showToast(
        msg: "Invalid Private Key",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
      );
      return false;
    } catch (e) {
      return false;
    }
  }

 static Future<bool> importWallet(String mnemonic) async {
    if (mnemonic.isNotEmpty && bip39.validateMnemonic(mnemonic)) {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/60'/0'/0/0");
      final privateKey = child.privateKey;
      final privateKeyHex = bytesToHex(privateKey as List<int>);
      final credentials = EthPrivateKey.fromHex(privateKeyHex);
      print(privateKeyHex);
      print(credentials.address.hex);
      await LocalDataBase.savePrivateKey(
          '0x$privateKeyHex', credentials.address.hex);
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Invalid mnemonic phrase",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }
}
