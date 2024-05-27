import 'dart:math';

String convertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18))).toStringAsFixed(3);
  return '$eth';
}

String publicConvertToEth(BigInt wei, String name) {
  final eth = (wei / BigInt.from(1 * pow(10, 18),)).toStringAsFixed(2);
  return '$eth $name';
}

String totalPublicConvertToEth(BigInt wei) {
  final eth = (wei / BigInt.from(1 * pow(10, 18),)).toStringAsFixed(3);
  return eth;
}


totalMind(BigInt wei, weiAmount){
  return wei+weiAmount;
}

String obscureString(String input, {int visibleCharacters = 6, int totalLength = 17}) {
  if (totalLength <= visibleCharacters * 2) return input;

  String firstVisible = input.substring(0, visibleCharacters);
  String lastVisible = input.substring(input.length - visibleCharacters);
  int obscuredLength = totalLength - visibleCharacters * 2;
  String obscured = '*' * obscuredLength;

  return '$firstVisible$obscured$lastVisible';
}
