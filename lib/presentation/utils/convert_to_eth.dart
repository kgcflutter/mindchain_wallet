import 'dart:math';

String convertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(3);
  return '$eth MIND';
}

String publicConvertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(1);
  return '$eth MIND';
}