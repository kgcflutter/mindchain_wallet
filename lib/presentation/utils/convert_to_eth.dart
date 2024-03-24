import 'dart:math';

String convertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(3);
  return '$eth MIND';
}

String publicConvertToEth(BigInt wei, String name) {
  final eth = (wei / BigInt.from(1 * pow(10, 18),)).toStringAsFixed(2);
  return '$eth $name';
}

String totalPublicConvertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18),)).toStringAsFixed(8);
  return '$eth MIND';
}


totalMind(BigInt wei, weiAmount){
  return wei+weiAmount;
}